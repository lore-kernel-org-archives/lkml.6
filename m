Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838055-2-8452502163288352778
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
    1524838054; b=UAjt1jTeuF9O9yRl+BORfWJz/YgbOYNtSObyW3wYCakF7ZDwey
    /uDdmXtkvYJL7QGjUer8Ww3lYaDTokXzY0IcpikkbyB9H0vLUrjsgJsZyOL+bnZO
    5gZrAL0Z9K18nresvkx+PvNyJEHzIOPXyQVouf1yI8xmja20Ore9plduOmc01Rhx
    u7clyX0/awv+B3Vvs9xSP0ftLXLSKOTsaNSLMeoZ3PGWtUJPVGsOsclOiQ1QSjxC
    ltavjgnRo4TbWqTEClOXc02K9wwD8U6pFK5ZmH57BC41Afkw4aKxpwX6WF7rtPKM
    bPzVX2f3oK0mwNERjHqG+jLsB6rgIbLJ1dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838054; bh=Mjjk1jdpOWHmuaqRnQZErPNEJjWbqN
    OLR2/d7zUm0Ps=; b=UUN/2N7oP311IBAlcAOxeI3ZAoV/imfasx6E9MX9f2cUCz
    +8VD4uE2e6VTpsWLp4uufrFp/c6h4qSDzcIPUMoAJ2MQP3AunDa2Aiu/eGXlDK4a
    6ECubrEyKXad/2pUmf5G5E67wkZqrEamBu3vVOTc66uXx7D/7Bxr0WNQ3bRs8OqD
    kRdgreUlwDc20CdJS3wFZCPrlyJShxF7LYh4oCWDo9B2BFPU+IMihT9DOj+W3Jy1
    7+PpwQYCP3tw3NDF6UamVD91lP0Y7yBEx1nmDvvE23oKxFVrOhsL5TsuzKFVUCDT
    dACwmCgn6vHahpSvtfxZ2AdrqsPpxM9emxTd80kA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGrTdJRWPRGWnZYuuU2ulqnQ0tGHPtBosdAcdM2zVCJXa0+LgquvEWX5YQ+pzkw5awMYRmu4Ap7LurpOJ97kXD52lCOWV/rCYy2mFbDFv5QmHJTb1jy2
    stzkTR91JtMWp9e8pH1XjKoUsILOZhGFTvIkBRyjLD0ejEb9O6PaSB33Bvq543Yw1aJuWxb4nwwKP3Py04ofz81tB3rEvBloFb+RMEpjOnYmmTYiqfSN7vl5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8 a=dK09jAgzlzuUulAh3SYA:9 a=QEXdDO2ut3YA:10
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeD0OHX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933954AbeD0OHV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB9E218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 07/80] Revert "ath10k: send (re)assoc peer command when NSS changed"
Date: Fri, 27 Apr 2018 15:58:00 +0200
Message-Id: <20180427135733.314628324@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

commit 55cc11da69895a680940c1733caabc37be685f5e upstream.

This reverts commit 55884c045d31a29cf69db8332d1064a1b61dd159.

When Ath10k is in AP mode and an unassociated STA sends a VHT action frame
(Operating Mode Notification for the NSS change) periodically to AP this causes
ath10k to call ath10k_station_assoc() which sends WMI_PEER_ASSOC_CMDID during
NSS update. Over the time (with a certain client it can happen within 15 mins
when there are over 500 of these VHT action frames) continuous calls of
WMI_PEER_ASSOC_CMDID cause firmware to assert due to resource exhaust.

To my knowledge setting WMI_PEER_NSS peer param itself enough to handle NSS
updates and no need to call ath10k_station_assoc(). So revert the original
commit from 2014 as it's unclear why the change was really needed.
Now the firmware assert doesn't happen anymore.

Issue observed in QCA9984 platform with firmware version:10.4-3.5.3-00053.
This Change tested in QCA9984 with firmware version: 10.4-3.5.3-00053 and
QCA988x platform with firmware version: 10.2.4-1.0-00036.

Firmware Assert log:

ath10k_pci 0002:01:00.0: firmware crashed! (guid e61f1274-9acd-4c5b-bcca-e032ea6e723c)
ath10k_pci 0002:01:00.0: qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
ath10k_pci 0002:01:00.0: kconfig debug 1 debugfs 1 tracing 0 dfs 1 testmode 1
ath10k_pci 0002:01:00.0: firmware ver 10.4-3.5.3-00053 api 5 features no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast crc32 4c56a386
ath10k_pci 0002:01:00.0: board_file api 2 bmi_id 0:4 crc32 c2271344
ath10k_pci 0002:01:00.0: htt-ver 2.2 wmi-op 6 htt-op 4 cal otp max-sta 512 raw 0 hwcrypto 1
ath10k_pci 0002:01:00.0: firmware register dump:
ath10k_pci 0002:01:00.0: [00]: 0x0000000A 0x000015B3 0x00981E5F 0x00975B31
ath10k_pci 0002:01:00.0: [04]: 0x00981E5F 0x00060530 0x00000011 0x00446C60
ath10k_pci 0002:01:00.0: [08]: 0x0042F1FC 0x00458080 0x00000017 0x00000000
ath10k_pci 0002:01:00.0: [12]: 0x00000009 0x00000000 0x00973ABC 0x00973AD2
ath10k_pci 0002:01:00.0: [16]: 0x00973AB0 0x00960E62 0x009606CA 0x00000000
ath10k_pci 0002:01:00.0: [20]: 0x40981E5F 0x004066DC 0x00400000 0x00981E34
ath10k_pci 0002:01:00.0: [24]: 0x80983B48 0x0040673C 0x000000C0 0xC0981E5F
ath10k_pci 0002:01:00.0: [28]: 0x80993DEB 0x0040676C 0x00431AB8 0x0045D0C4
ath10k_pci 0002:01:00.0: [32]: 0x80993E5C 0x004067AC 0x004303C0 0x0045D0C4
ath10k_pci 0002:01:00.0: [36]: 0x80994AAB 0x004067DC 0x00000000 0x0045D0C4
ath10k_pci 0002:01:00.0: [40]: 0x809971A0 0x0040681C 0x004303C0 0x00441B00
ath10k_pci 0002:01:00.0: [44]: 0x80991904 0x0040688C 0x004303C0 0x0045D0C4
ath10k_pci 0002:01:00.0: [48]: 0x80963AD3 0x00406A7C 0x004303C0 0x009918FC
ath10k_pci 0002:01:00.0: [52]: 0x80960E80 0x00406A9C 0x0000001F 0x00400000
ath10k_pci 0002:01:00.0: [56]: 0x80960E51 0x00406ACC 0x00400000 0x00000000
ath10k_pci 0002:01:00.0: Copy Engine register dump:
ath10k_pci 0002:01:00.0: index: addr: sr_wr_idx: sr_r_idx: dst_wr_idx: dst_r_idx:
ath10k_pci 0002:01:00.0: [00]: 0x0004a000 15 15 3 3
ath10k_pci 0002:01:00.0: [01]: 0x0004a400 17 17 212 213
ath10k_pci 0002:01:00.0: [02]: 0x0004a800 21 21 20 21
ath10k_pci 0002:01:00.0: [03]: 0x0004ac00 25 25 27 25
ath10k_pci 0002:01:00.0: [04]: 0x0004b000 515 515 144 104
ath10k_pci 0002:01:00.0: [05]: 0x0004b400 28 28 155 156
ath10k_pci 0002:01:00.0: [06]: 0x0004b800 12 12 12 12
ath10k_pci 0002:01:00.0: [07]: 0x0004bc00 1 1 1 1
ath10k_pci 0002:01:00.0: [08]: 0x0004c000 0 0 127 0
ath10k_pci 0002:01:00.0: [09]: 0x0004c400 1 1 1 1
ath10k_pci 0002:01:00.0: [10]: 0x0004c800 0 0 0 0
ath10k_pci 0002:01:00.0: [11]: 0x0004cc00 0 0 0 0
ath10k_pci 0002:01:00.0: CE[1] write_index 212 sw_index 213 hw_index 0 nentries_mask 0x000001ff
ath10k_pci 0002:01:00.0: CE[2] write_index 20 sw_index 21 hw_index 0 nentries_mask 0x0000007f
ath10k_pci 0002:01:00.0: CE[5] write_index 155 sw_index 156 hw_index 0 nentries_mask 0x000001ff
ath10k_pci 0002:01:00.0: DMA addr: nbytes: meta data: byte swap: gather:
ath10k_pci 0002:01:00.0: [455]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [456]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [457]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [458]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [459]: 0x580c0a42 0 0 0 0
ath10k_pci 0002:01:00.0: [460]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [461]: 0x580c0c42 0 0 0 0
ath10k_pci 0002:01:00.0: [462]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [463]: 0x580c0c42 0 0 0 0
ath10k_pci 0002:01:00.0: [464]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [465]: 0x580c0a42 0 0 0 0
ath10k_pci 0002:01:00.0: [466]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [467]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [468]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [469]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [470]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [471]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [472]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [473]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [474]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [475]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [476]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [477]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [478]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [479]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [480]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [481]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [482]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [483]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [484]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [485]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [486]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [487]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [488]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [489]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [490]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [491]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [492]: 0x58174040 0 1 0 0
ath10k_pci 0002:01:00.0: [493]: 0x5a946040 0 1 0 0
ath10k_pci 0002:01:00.0: [494]: 0x59909040 0 1 0 0
ath10k_pci 0002:01:00.0: [495]: 0x5ae5a040 0 1 0 0
ath10k_pci 0002:01:00.0: [496]: 0x58096040 0 1 0 0
ath10k_pci 0002:01:00.0: [497]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [498]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [499]: 0x5c1e0040 0 1 0 0
ath10k_pci 0002:01:00.0: [500]: 0x58153040 0 1 0 0
ath10k_pci 0002:01:00.0: [501]: 0x58129040 0 1 0 0
ath10k_pci 0002:01:00.0: [502]: 0x5952f040 0 1 0 0
ath10k_pci 0002:01:00.0: [503]: 0x59535040 0 1 0 0
ath10k_pci 0002:01:00.0: [504]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [505]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [506]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [507]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [508]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [509]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [510]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [511]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [512]: 0x5adcc040 0 1 0 0
ath10k_pci 0002:01:00.0: [513]: 0x5cf3d040 0 1 0 0
ath10k_pci 0002:01:00.0: [514]: 0x5c1e9040 64 1 0 0
ath10k_pci 0002:01:00.0: [515]: 0x00000000 0 0 0 0

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/mac.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5955,9 +5955,8 @@ static void ath10k_sta_rc_update_wk(stru
 				    sta->addr, smps, err);
 	}
 
-	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED ||
-	    changed & IEEE80211_RC_NSS_CHANGED) {
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM supp rates/nss\n",
+	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
+		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM supp rates\n",
 			   sta->addr);
 
 		err = ath10k_station_assoc(ar, arvif->vif, sta, true);
