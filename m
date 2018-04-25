Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652775-2-5851675940869421568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652774; b=EhTZFzQV7o6aOJPaFYWFuy162+i6peZnDl6J+BK4RyXhYdUZbd
    NCAnMi6A+MwJ464jFxDGnexQIoiblYlcFuxKV4Xn5xdl43GkNtbK8JaI1XzTmXD5
    eVr4lIu3yDKCK0+gCmwQHmmsBoXjtNJwMchBOLizrJbpRoMuXaSodritdRTAVvHd
    lozA/SZ8DJwBYCsXsMcimC5azByX48III+ZFRFWOuRse8mc2JC0EzPAicJ1OKZuM
    THJKnOn45VHUbHr/R5EigXnIZpdvVkmqqcn5SQnpzCv9wDleJPeu/PrMUNHhn/J4
    aIZ1JL7CBddyi79wRgZ2sFnr8SUk8ClZhjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652774; bh=jWE5JFCyuthb8OFMBJcxaBpqHrK38N
    pDI1bcKBT4LQY=; b=rTRtg9W8W80hktbQUeIS4Xr7sAu4gUe4QNhJ5uFrDrQhy/
    Pd7LDVuP4NptpsyXB2Za9n71zsesOTGlX3xREPsyIlpumv42FWl/bvOUTxqXGwhC
    q5rTbEk32cdbrQWjRlFymZ/HV+kbtUeM+7sKz+lrlcppMTtuXk/hMHXgGNt+x2/n
    e9eqfd8e2fZYF7ctsORpFyZvYSlcv1jSsLVEu4bulfUdU82dk8r43itNcETtf//o
    LL92K/Tr5D3cQGuItVfj9qqnT/GOA73Q0he/p+fKBq7bqqS3WfJ0xmFYsg9fZuVV
    wLuSOo/SxBAY5aUmG1PWdFl0PfuR3kUzM7GGUX6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPA53JubTwyyrfh9XaS3n8nREgv2sg8VVYCx4rQMqwityAOw85QjioNoWre7rvRszPPkgX1UOtY7wcrxjZVdLWNzo9WQD62XIqc4FcKDwrhubcwr/UCi
    tPWxD9YTi8r4hBn8YBQiFwWix3j5hrOyq5C2C+F7X4swooBY1ifeuwviGUpMJeaGO18nF9eVD8CEVtvE0MB1uuZC/T3j20NG0RpsJ04tbWJz2zAQdB2VsmOJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=1vR2FzZSdyBwo_47p4gA:9 a=NIAjlYWqRhg7dnxx:21
    a=3CTzTRG5P5rEgITL:21 a=QEXdDO2ut3YA:10 a=3ZumFrijQQ-2J9H5h8ct:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeDYKja (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:39:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbeDYKj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:39:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/183] mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()
Date: Wed, 25 Apr 2018 12:34:41 +0200
Message-Id: <20180425103244.985362021@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: "weiyongjun (A)" <weiyongjun1@huawei.com>


[ Upstream commit 0ddcff49b672239dda94d70d0fcf50317a9f4b51 ]

'hwname' is malloced in hwsim_new_radio_nl() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: ff4dd73dd2b4 ("mac80211_hwsim: check HWSIM_ATTR_RADIO_NAME length")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3153,8 +3153,10 @@ static int hwsim_new_radio_nl(struct sk_
 	if (info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]) {
 		u32 idx = nla_get_u32(info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]);
 
-		if (idx >= ARRAY_SIZE(hwsim_world_regdom_custom))
+		if (idx >= ARRAY_SIZE(hwsim_world_regdom_custom)) {
+			kfree(hwname);
 			return -EINVAL;
+		}
 		param.regd = hwsim_world_regdom_custom[idx];
 	}
 
