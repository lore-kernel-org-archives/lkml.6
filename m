Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484292-2-3185820891702134203
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
    t=1521484291; b=KwhCQOotV5NxKkzBaI4444Kh+3qf3a7F1nVlsZJLiKeIpOk
    7BNCn1f0P4D4AFYd7qAcsh4VAFg++LPcQN6BMSfKdEQuDKIem71g17RYoMTQwMHs
    EAHp3kJnrHV6dVIRK3HVzY2O897e/ZFdnMCOJoIQg/lf0pAQiDUIgco1JZa+cgxh
    lldxAWxogNMtowN0aOX9cLkDpPTt553Gdtsr8dQclFTVmLHGoTlT+1HogItCHFhg
    pEsnbYRN8z/cYLmc+MUer6pRmq6ITdaSybGhfjfExmGSVfS90nE6fAhN7E8vSRjQ
    l7jPy+sjk7nnvXURSbgZ4tYYnEZvt0nvcfgWw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484291; bh=HeD2m38JQq7tRWNFem7eJ3+06d
    q8Y6JmgdkTXldXTE8=; b=AxoEiB6KCy1w5bMSlHror282Gso+7HTh7tvA19uyWB
    R8/d7yciboZmiw2mzsd3f2uiKjUM4mODWruKVjSVNpAq6St9y9/q7wnzFRjGU0tA
    sspDAFfK49Dz2hlRlH75AxMfYgp8KhpQvmSf2N2NaxPLQKv3zTkYyf75SKlJXGyp
    jJW7HUy3V1iooinyd8DqBe9X+vL2qbv5T3QCXvWKIS2NINaAYsWqbb2DXY1nfvPG
    cZjLXRpzyjH08YrG6Sehp4Apn+rJWpdlNy/sySp7mbF08VL0Q+FdYqsUAz0G5lUf
    lesbFRJndw5q0NEgOVyIzpAXBXwmBLp5Sqzowc9w+4lg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeljeejnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeljeejnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935680AbeCSSbT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:31:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032052AbeCSSbQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:31:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 12/52] ALSA: hda - Revert power_save option default value
Date: Mon, 19 Mar 2018 19:08:10 +0100
Message-Id: <20180319180735.811105444@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 40088dc4e1ead7df31728c73f5b51d71da18831d upstream.

With the commit 1ba8f9d30817 ("ALSA: hda: Add a power_save
blacklist"), we changed the default value of power_save option to -1
for processing the power-save blacklist.
Unfortunately, this seems breaking user-space applications that
actually read the power_save parameter value via sysfs and judge /
adjust the power-saving status.  They see the value -1 as if the
power-save is turned off, although the actual value is taken from
CONFIG_SND_HDA_POWER_SAVE_DEFAULT and it can be a positive.

So, overall, passing -1 there was no good idea.  Let's partially
revert it -- at least for power_save option default value is restored
again to CONFIG_SND_HDA_POWER_SAVE_DEFAULT.  Meanwhile, in this patch,
we keep the blacklist behavior and make is adjustable via the new
option, pm_blacklist.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
Fixes: 1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
Acked-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -181,11 +181,15 @@ static const struct kernel_param_ops par
 };
 #define param_check_xint param_check_int
 
-static int power_save = -1;
+static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
 
+static bool pm_blacklist = true;
+module_param(pm_blacklist, bool, 0644);
+MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
+
 /* reset the HD-audio controller in power save mode.
  * this may give more power-saving, but will take longer time to
  * wake up.
@@ -2300,10 +2304,9 @@ static int azx_probe_continue(struct azx
 
 	val = power_save;
 #ifdef CONFIG_PM
-	if (val == -1) {
+	if (pm_blacklist) {
 		const struct snd_pci_quirk *q;
 
-		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
 		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
 		if (q && val) {
 			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
