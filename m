Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163510-2-4478746077201187740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163510; b=BoxDO/ioUvGLxhl+u2/bmb3ksbO2Yuip4rV76J0bikWac0/Pfb
    RYyApgAuuSny/BSZB917b/5BlzzJfc1R8KnrpXAX0fqzqAwnl+Ybztp1A42iSX6w
    Eg5XeBX9FYkOxpCt1SPjvLoGFpCtRS8WSheXEpZD2cak9KaQfoAAXJcIXYahgvYs
    sAgwxw/RL7Y/+tC4BbWrpkAw2ro/Lf5itLwLgwYSgTzX6th2QB1E36BXNkJIjcxq
    Sp2jszAMsLKUxVNqtn8QG5HcZVseZVYbYeXDe+mOtontbAmOS4UKMbC7BNoE8Jqa
    Xn0QWWWB3b+DFDkSpJlmHnQa//JjBGJcTTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163510; bh=hgMg6EmAM46XLylj6Pi3Bpvmxr6gz4
    2eFJJJDVZUEMc=; b=GQq6Pc/3YL1q/GaD++urahdB7kzI0J/kFlwnXIPmPvFzlF
    tpOspUVUbXObqoaIHQ2qe0F/1WjgWf3RXDgFsqRGVIkm7F3gx5R7th0kBx5M3jSG
    J3C9T8WDhl+KLLT+KGNcB6+sCeut/HllbjispzvH4lcjquBqgWWwKBx+EUH07Vzu
    B0kuKkfwzDawYULJR1bllnoyv6uXEnZLK6hHdYkzGUihn/YzWrufMMBYTrDXZNHJ
    JWY90+WOxKG0GpNF/4Y+/YJG0LRXayQFE1sJyCkx7HR9fhAF8eQwB+wspteyYxe7
    fQIt7zXHTPU6KRLj9MXqdTvwwU6k5A3rYvT5KglQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xLVZh607 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xLVZh607 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOVh6fYqZHyBG054PSSgNcFzdhczia5valdCHEqlKUotL7bhJLCCohzYqcBBU6ozURE4SbI9n1MdLykzuwXKvB1XE2+JwAf+epXA2hBYiI56I1b4qsUp
    49umWeF0C8u2vn2FiAqo7+yNKMKP8XV12q96ZtIlKR7+SJvz5YtV7GMnwfeQ+YDMuqh7tRdhY+1LtjFLnxoNyA7rKc+f3hQ1C2kOGdP5jscT9TpRkwAsEF3r
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=hPSAIb3oeYGiYc3EuFoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969592AbeEXMEs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966584AbeEXJoV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 39/92] ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist
Date: Thu, 24 May 2018 11:38:16 +0200
Message-Id: <20180524093202.762935773@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit c8beccc19b92f5172994c0732db689c08f4f98e5 upstream.

Power-saving is causing loud plops on the Lenovo C50 All in one, add it
to the blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1572975
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2072,6 +2072,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
