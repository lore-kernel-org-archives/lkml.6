Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172409-2-13783112240153455616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172408; b=vhx5HCe++dX6ltGYWkX3GmRAn5dEeu5VO92aUKLcU73ya8N
    nnfIj1nu0NCd9xAf/jdsc1fxoy+otzSr4Y953SrUVj9I8Q/1kKV0eUh0alxYef2x
    r+nGwuRbadnw+zaFiyaV77RxLl6cFbsxv4miKhAlkjGxM+kCL8IcxVSetJami51e
    1gyWLjh0WcpQCXBYSHjjAYvsm1cumLy1EIwB/QgsT/RoNNFVIgbEcqpvAY/w6HZV
    TLZmT27J8R2mDBPMv8uU8dxjhxn44/U7hl04EdmgZNTfMug3glakL7Q0Yjl4ifo4
    UjgRi3eYLUWgtQ05UltpmWHTD2cPmOOJUVSRbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172408; bh=hr9DYh4+enkL3gL3ygbs5BSO4a
    ZAuiOcCQvVJmvWtzs=; b=SE3jjF1HRdiqSHSydLCMWMmi96YVAEAGTPIsZgNscl
    +g6h0cbfFlZADB/yO0PyGGOJuvpV5x98NTSijZKFVL2h1CjAuKcLpeI8DsS2kimQ
    rb9zG3SLi5K4e5HtNntMdte++CVr/Q8L28CNpE9OkRMfyJigB1YKX7TrNxI9EJda
    5cmfe7vXmhySX7tgWC85BQel3vHTlSJTOLX9OK1Ql5LOfig+IFRFBgX6SF9OlXXL
    91/vlltf+OVbvWzx2TCypLsN9zEKS+V6GhKRubTIsHQ9IeVSkb4niIgw2i8iSdXW
    fXemCMPfPXWOX8kHaEwIEOEPdJOCmzQ01v0Uvoi/gUCA==
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
X-CM-Envelope: MS4wfK8cdMF6AokEBDvlGhubYa7NFLtorJjXdnZ7uImDYUKN7BMeGWAYmzJqQFasZLL7l/22+DpTwNWVlzAqjSeYs1aamSk3ufefzXIY4d8Fy8Qo6RfVk/Gp
    oTzb4tRKhBmMIXb3m39b/H7jHFocaTjZl9K192cBMKq8CCyIdYia3UZREmgOdnlMJuPfi6WEwbe+FZUJa3W8Xrluav2lBWLVjDZVQZwc+WPBh4haX2wNRPkm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8
    a=s8YR1HE3AAAA:8 a=swAopTDVAAAA:8 a=hD80L64hAAAA:8 a=KKAkSRfTAAAA:8
    a=ag1SF4gXAAAA:8 a=0K8Ke2wkkT2Jzjzvz9kA:9 a=QEXdDO2ut3YA:10
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
    a=jGH_LyMDp9YhSvY-UuyI:22 a=7aPqbiTMDNvH6kBvy-t8:22 a=cvBusfyB2V15izCimMoJ:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeC0QeT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeC0QeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 019/101] mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
Date: Tue, 27 Mar 2018 18:26:51 +0200
Message-Id: <20180327162751.150880077@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
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

From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

commit c7151602255a36ba07c84fe2baeef846fdb988b8 upstream.

The commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
and commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
made changes, which cause multiply overflow for 32-bit systems. The broken
timeout calculations leads to unexpected ETIMEDOUT errors and causes
stacktrace splat (such as below) during normal data exchange with SD-card.

| Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
| -  Info: Finished target initialization.
| mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd
| response 0x900, card status 0x0

DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
code gets compiled on all 32-bit platforms as opposed to usage of
DIV_ROUND_UP when we may only compile stuff on a very few arches.

Lets cast this multiply to u64 type to prevent the overflow.

Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: <stable@vger.kernel.org> # 4.14
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -413,7 +413,9 @@ static inline void dw_mci_set_cto(struct
 	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (cto_div == 0)
 		cto_div = 1;
-	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+
+	cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
+				  host->bus_hz);
 
 	/* add a bit spare time */
 	cto_ms += 10;
@@ -1947,8 +1949,9 @@ static void dw_mci_set_drto(struct dw_mc
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
-	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
-			       host->bus_hz);
+
+	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
+				   host->bus_hz);
 
 	/* add a bit spare time */
 	drto_ms += 10;
