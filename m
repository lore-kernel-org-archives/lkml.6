Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3559911-1519411123-2-13903975777486312828
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
    t=1519411123; b=b2l2NMTNP5yabUUepw0294wntlcYDCK3Qngx0vCwutUm8N3
    D30rGtiXpm/czFllE2fHS0Rep6bhb9gxrQpjGfxmzwn4OVHbDr2v7qO254OudAND
    aBG7HuUE55+UgAEZS9gugszJWqEA5raiI9QP+rF5gxp3rHzFE1l4fydhABw/qe6J
    NralARW0B2NM1f4rhMxXgoCEDVNqs5N2+WHYOuoz6Ou0YQ/oND6GgVsrN32Q9D77
    UdjnrSXTvi7708CQPRoEvYnOnXeugOuRezz3nrs47QBGBVWJMkYDCnqG7g6kzg17
    9d2dtm9s8LG2rrm8xgTWVjGndM4bVsuNVdmK89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411123; bh=ZMT5V3KdQXU7zXqMgW1H/i1b5v
    Bp4LR1XMuEkxmLkfM=; b=R96V8BGVHsSh7Oej/eH6d3MudPz/T8f3vrNr79P9xV
    Ypd65GOP2BZpQ8FuvfjoUryHRO6I2CjG5oQX2jiCpDnPCtodvGTe4ztZZkqaun8W
    0b6HDA4Y3kOVlQXF5Y62tOTQchS0jtx/lhIyumq4Y2YX6tOo4v/+mdtC13ZfTm2o
    xNKQOHAU8wTOeNJG94AHIkN0opHPROpOmDcZWtvYDn47LJ4M+pKsqNxfEgqZyvF3
    MOmv9OupiMcfW8AUd29AzknuLDaU5s/IPCKb0sxF7di68lzLlMaCMrPlZ0NMrjut
    ngWD0uzvCcVuHUWdS2t5u83NxjJ1kxy3yrsQqG7u6w7g==
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
        id S1754315AbeBWSih (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:38:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbeBWSig (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:38:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.4 128/193] i2c: remove __init from i2c_register_board_info()
Date: Fri, 23 Feb 2018 19:26:01 +0100
Message-Id: <20180223170345.922970960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis R. Rodriguez <mcgrof@kernel.org>

commit 5abe9b26847c65a698f38744a52635b287514294 upstream.

As of next-20160607 with allyesconfig we get this linker failure:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x21bc0d): Section mismatch in reference from
the function intel_scu_devices_create() to the function
.init.text:i2c_register_board_info()

This is caused by the fact that intel_scu_devices_create() calls
i2c_register_board_info() and intel_scu_devices_create() is not
annotated with __init. This typically involves manual code
inspection and if one is certain this is correct we would
just peg intel_scu_devices_create() with a __ref annotation.

In this case this would be wrong though as the
intel_scu_devices_create() call is exported, and used in
the ipc_probe() on drivers/platform/x86/intel_scu_ipc.c.
The issue is that even though builtin_pci_driver(ipc_driver)
is used this just exposes the probe routine, which can occur
at any point in time if this bus supports hotplug. A race
can happen between kernel_init_freeable() that calls the init
calls (in this case registeres the intel_scu_ipc.c driver, and
later free_initmem(), which would free the i2c_register_board_info().
If a probe happens later in boot i2c_register_board_info() would
not be present and we should get a page fault.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
[wsa: made function declaration a one-liner]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-boardinfo.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -56,9 +56,7 @@ EXPORT_SYMBOL_GPL(__i2c_first_dynamic_bu
  * The board info passed can safely be __initdata, but be careful of embedded
  * pointers (for platform_data, functions, etc) since that won't be copied.
  */
-int __init
-i2c_register_board_info(int busnum,
-	struct i2c_board_info const *info, unsigned len)
+int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsigned len)
 {
 	int status;
 
