Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D0EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C7820852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C7820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935559AbeFRPHn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:43 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935468AbeFRPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:39 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LdEht-1fux1l1vNp-00iTHh; Mon, 18 Jun 2018 17:07:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove get_monotonic_boottime()
Date:   Mon, 18 Jun 2018 17:06:50 +0200
Message-Id: <20180618150717.1066151-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:qQA/lxB+s/mRpqdVnzDyjBcFIJGUnD/MOaHqVVo1CwixyEc8vb0
 Z246PEe63CnDK1dIAPPtCrO8cjxSeTIGVXFGjeLrywMNtmXVRp/yWpDgBJGwlU845uGZyxd
 E9tFneyf2wxsf3XPKcyV7NfZQ0kI81NUEBS0uiBtvW2iI648upUBCABFYzglwZPF/1Am4eL
 ZSw673FNwymep5g1Rya1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QIE3hLmpzvo=:cKZD18z2UAA7d1PAVSVEm+
 7g78tGRFEG4MRc8xgBRUGKr2TaDr4ujGqJvT6DXmBlaCeVIGFyRXMwTbJoz7TR6r+Yh2KqFeO
 KEIk8SDssT1cGr0AQrQQIP6Ayl91baG4yXSDvMQ5YVNWrYxj7j9XZ3CZBziA+bWBqpVXAHDws
 gP3mQEwSeV5Ie0gRJwkxg1XXFva5OriiVMdsIY+Arda97407Y98O5RVRkQ2lv8MNvQsl+BeUm
 r44P7coRJ2LuAwMn96ubKkgJ7isNvnDQmVl6EDJ1blRuSKbdsZqbYNWEJ4PqETR5Z1Wmn4rOg
 YDKSPRn0dBmj7KlSJn6rTbtvAg+UYDXFJq6w6EkyB6pyDvESGOgEvayTTtU8uuuVC0Z+pBH1z
 IBjQF6CXeC2xl95WEYRTWZYH4gerMfwmQdjH1ixphcy3FrgEAMQ+i/CfFYNLSrj8jgkQiV4Gg
 qiaK+HoyJkVgts8JQz2FyaU9l0p+CLNss3P4jTGsh6Aq4GdLVPp5sxdWaoy0FhA1wSaZOS5SR
 uxIYDsiyn+dkDnsAalh4Ig20wZtAQd/sf0fObqP2HkLLbN5phcRNzYgJB6WlbOzKWIpsIjz9I
 qd7Nw4T+9Xm8cB2ILpSu7ca4d6nkAAAusbkJGD/zi/GdSbBogH7VOQNIe1Ntj2nIAH5KKHwIE
 8LDz/WK4n7U41BFLcwBSKaLxlagsrpwnD0RUcPXlvn6QTUVeUlCDuDomWhXGlqKQGPoo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated because it uses the
old 'timespec' structure. This replaces one of the last callers
with a call to ktime_get_boottime, which also simplifies it
a bit by avoiding a double conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 02178e25fbb8..73fc3a742f74 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -233,13 +233,6 @@ static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 	return 0; /* not supported */
 }
 
-static u64 rtw_get_systime_us(void)
-{
-	struct timespec ts;
-	get_monotonic_boottime(&ts);
-	return ((u64)ts.tv_sec*1000000) + ts.tv_nsec / 1000;
-}
-
 #define MAX_BSSINFO_LEN 1000
 struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wlan_network *pnetwork)
 {
@@ -331,7 +324,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 	notify_channel = ieee80211_get_channel(wiphy, freq);
 
-	notify_timestamp = rtw_get_systime_us();
+	notify_timestamp = ktime_to_us(ktime_get_boottime());
 
 	notify_interval = le16_to_cpu(*(__le16 *)rtw_get_beacon_interval_from_ie(pnetwork->network.IEs));
 	notify_capability = le16_to_cpu(*(__le16 *)rtw_get_capability_from_ie(pnetwork->network.IEs));
-- 
2.9.0

