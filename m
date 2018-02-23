Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413713-2-10807435718851866369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413712; b=rfvzbFiQqwZUrv4JjN7XJHbhDL60fj7E9F/zGxAYkqYt+nO
    ucceZYc19hPc7KdgFdzupmifPRn/XH064QX02ColZuuQYuhBRvk2RqXcbG1MccSP
    U8htKUNg/6aQDpnJpe0CKKAksQJprwzJtHVwAtBX4qEco9saJ3QLNJMKw45/130M
    NpsTP8psp8nnvq1cM+n5USfpqOXZpkx2UGjR8kvd2bDLpdNBI9scyHAU2yBp/h2C
    dsvgUTA4Wq1Vw4diAAa1QyyHtWN5q5K2O7Fw0aMSW3McPk3omK/jpiKc18A5DiBr
    XW55TMmI3gKa1NeVAUCOLxKoIoKuTK2qurMf7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413712; bh=CJFwxHBiGJIYWkxd1PfbF7ZCDC
    v1cYBDzEXkja2RffI=; b=L7cAxNW9IOfgRfMr/xtGwAwHZZgcf1oaxrKJOO4lg2
    bh91aoV/J7Uo7/2LLOEgklhnDZU1cfuRK3mqzVDSE/HUgk0hkv6GKZYqTS7rhP5C
    /3tIsFK5P78pXLoxX21d2OJITxn9tKuDY/CvDtJjzpdtzNYJlcu6yZDlm/HLRU4j
    rnhcworfH5/axD64L7Baded6OzS7xQpZiknh1sg7ju/K0euwPYdhW1yi8YLlWhB/
    qM+It+zvblXYI4z0sgLpwR0+v8gzcGSvdvHtfAm/uaRyUFZTGvczRIlLc55sdYjA
    +pflocu7uZQ6U3yOO906vFdUYEdBomiQHttlD/abuMhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964785AbeBWSxv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935140AbeBWSxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 100/159] iio: fix kernel-doc build errors
Date: Fri, 23 Feb 2018 19:26:48 +0100
Message-Id: <20180223170755.555155112@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>


[ Upstream commit c175cb7cd953782bbf4e8bdf088ad61440d6dde5 ]

Fix build errors in kernel-doc notation. Symbols that end in '_'
have a special meaning, but adding a '*' makes them OK.

../drivers/iio/industrialio-core.c:635: ERROR: Unknown target name: "iio_val".
../drivers/iio/industrialio-core.c:642: ERROR: Unknown target name: "iio_val".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/industrialio-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -631,7 +631,7 @@ static ssize_t __iio_format_value(char *
  * iio_format_value() - Formats a IIO value into its string representation
  * @buf:	The buffer to which the formatted value gets written
  *		which is assumed to be big enough (i.e. PAGE_SIZE).
- * @type:	One of the IIO_VAL_... constants. This decides how the val
+ * @type:	One of the IIO_VAL_* constants. This decides how the val
  *		and val2 parameters are formatted.
  * @size:	Number of IIO value entries contained in vals
  * @vals:	Pointer to the values, exact meaning depends on the
@@ -639,7 +639,7 @@ static ssize_t __iio_format_value(char *
  *
  * Return: 0 by default, a negative number on failure or the
  *	   total number of characters written for a type that belongs
- *	   to the IIO_VAL_... constant.
+ *	   to the IIO_VAL_* constant.
  */
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 {
