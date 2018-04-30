Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116384-2-16257551463706789018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116383; b=dCvmi5PHHn0P86Fg08wmw4YaxOrw/vu2Rvy+grYsyQcDCEiuai
    o6J/GSNEtUpJazSWJ3cWUKQQn8qInGp34pKTdzFGE686FepWF6p7y7L43qyjHr6/
    eDkz3JLsusi9yNQkdFJhX0ALzCVBvLgoOi4kBQbUzdwxQCjdSnnMUR9ImiShwesK
    MrX75zip6kz8phzsrsc+lhS6HM2G0bJvL21ZIB4aRJJBLVMc90lGNmhuzU4+ts+4
    JJLRmNrYQrMay4FsfS6lcqYlRqmuu/scswo+JGWAAqG2+bnNPEYJsVeg8NbSSL9V
    hjGaSUw/F1mbYUp1vjSpE76cpnJLpFLDgToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116383; bh=ddJW8lEiKfie3A0DvUEz/M6jrbljyx
    UoHl/UeliA33I=; b=mmgYmaCqX1SJiwyTqIrMVhHyhvUKjqnwSq517DpZss87Aj
    +ecDLfYnIYGGCbJ17ArPrsQNF6cnE35AyzSYgBitA5HihlntJxKtQk8ITVbHWvu+
    Ik6Bq5EPYY+C2w62kVB1s0GMXYM7X3HxoCOFzDQgMkE47JGXqXfDhfeboaLiwIGs
    hM5gnZ+AsdULgDmrM5PbjQe/sIyxQ0MsabCwzDwSuXYAGGeI/U0sGF1kWmiHw0Gf
    C4cMTyVDmGs2r+/wyVi3AwXwhMAskqzqZWap5HEPSKoMolj1XWCOiRhfaQAgwh63
    1/9jqA/WkKI9fQJs1NFxQ4byHKtWg6uJtKn25yNQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBvbi5h8IuelSX1NTXquRsFvxL6svo3SyRAr1MT4Y7a3TnCjTTijRVeWG3k/98RrY404uL2wC0Hnk+BDf3pj//FGmJoinBSy2Y/nYEVbR7kiQuQQMfms
    GiEjz6x2Bh4ADfP563k3O5OZyaUPJODWDPpSHvHqTNxOMFLo+qVecVhN1b9ZEdHO4Kd/C+Sz/pFMJbZKFobgbz/fwt3cMElMrJuLQA4hstXEzeEyR1YPOGif
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=rKoUXa0mWBmEpCJEgDcA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeD3T0V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755583AbeD3T0U (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7584422DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 16/61] ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
Date: Mon, 30 Apr 2018 12:24:19 -0700
Message-Id: <20180430183952.558872856@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 1d8d6428d1da642ddd75b0be2d1bb1123ff8e017 upstream.

The Dell Dock USB-audio device with 0bda:4014 is behaving notoriously
bad, and we have already applied some workaround to avoid the firmware
hiccup.  Yet we still need to skip one thing, the Extension Unit at ID
4, which doesn't react correctly to the mixer ctl access.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1090658
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer_maps.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -353,8 +353,11 @@ static struct usbmix_name_map bose_compa
 /*
  * Dell usb dock with ALC4020 codec had a firmware problem where it got
  * screwed up when zero volume is passed; just skip it as a workaround
+ *
+ * Also the extension unit gives an access error, so skip it as well.
  */
 static const struct usbmix_name_map dell_alc4020_map[] = {
+	{ 4, NULL },	/* extension unit */
 	{ 16, NULL },
 	{ 19, NULL },
 	{ 0 }
