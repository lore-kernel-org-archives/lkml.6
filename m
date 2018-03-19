Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483674-2-6883116707428947488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483673; b=A8WoYUzNcFh17eM6b57XYLbEMgv3JnayX82tfa8NgyLSMUh
    n7+YYwet1u5N/sNHIs3/UKPsOojbKPExMLvwI9SAuJXegJs2Glabd+P0pzheA5qt
    Z6aGg7rzYZTv841hMekXBxSeh2lkVn7qMcGaxSmqF/IJoEbfiMMeS4AGnUKe32x8
    5pl3DYAsru0/4O8P8Y939Jfzc/AKXqygSsRXtbGV5UXb3DotnJJNVfQj9i77fNZE
    6ySTT2W2MxQ+aTUQpRn6p2E/AO4wTCWklIneTymaZ/8+Ij6W+ETw2EWf5hza88W1
    zeSBKAXJPHUbHvNLe7s7X7eLUJt6LkkkgTgODXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483673; bh=dt93g7RG8KH6QJI/BCp9P1QYBd
    Wmv8XtVcP2maPs1h0=; b=kP85/u5PrqAcdop0C5oqo0wz7ukjuA1iAbO1YJt5sm
    oiIf0bLw9Pq/Wi1OL0tfrY00UJF3BXUYMG0yXCMhMSeG+9rQncRP8PdGdS1GRK7q
    /u6CAbmX2FaDzNZKhOKFIm3wE9x4IW72LI/4duKURzmTyBUCkhoRXyphHmcMOPUl
    +wYKeF0EA6a9/PCxcH07o1zpQcZ3XMbHEeISUfsBXsdvVpAnyJDzi4CFZVuwVjMj
    5SBYPKr+3brCoLmudQMsbMvqO0qaeGMslWnXOoJFIRpLuOqNLRosVN9DFg1vQQTp
    zzKaLTy6PJMLoMjr92O4IZiM5QLLeob+syVmpQ9aTxdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinheprghnrghlohhgrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdelkeeknecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinheprghnrghlohhgrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdelkeeknecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031033AbeCSSVG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:21:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031021AbeCSSVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:21:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shikhar Dogra <shidogra@cisco.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 072/241] driver: (adm1275) set the m,b and R coefficients correctly for power
Date: Mon, 19 Mar 2018 19:05:37 +0100
Message-Id: <20180319180754.184440787@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shikhar Dogra <shidogra@cisco.com>


[ Upstream commit 6faecba0b3da7b617bf72bef422bf0d3bb6dfe7d ]

Seems like coefficient values for m, b and R under power have been
put in the wrong order. Rearranging them properly to get correct
values of coefficients for power.

For specs, please refer to table 7 (page 35) on
http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1075.pdf

Fixes: 904b296f308d ("hwmon: (adm1275) Introduce configuration data structure for coeffcients")
Signed-off-by: Shikhar Dogra <shidogra@cisco.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1275.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -101,8 +101,8 @@ static const struct coefficients adm1075
 	[0] = { 27169, 0, -1 },		/* voltage */
 	[1] = { 806, 20475, -1 },	/* current, irange25 */
 	[2] = { 404, 20475, -1 },	/* current, irange50 */
-	[3] = { 0, -1, 8549 },		/* power, irange25 */
-	[4] = { 0, -1, 4279 },		/* power, irange50 */
+	[3] = { 8549, 0, -1 },		/* power, irange25 */
+	[4] = { 4279, 0, -1 },		/* power, irange50 */
 };
 
 static const struct coefficients adm1275_coefficients[] = {
