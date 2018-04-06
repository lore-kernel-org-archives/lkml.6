Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021475-2-16568452765815843735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021474; b=GIG8MmAmLwtBTU8skb2rDWLDGfcHyAZ5P0S8kwHm1coA/sbJ7m
    BP2beKntOiQJ49/FFOFLVS1Vkzxbz0OW9qwp0nwZ18Ceh1Q9zFpOIdnb1cluWLTl
    NQebjErTbK4GdxAuKYXbrW+hGqH4L7mZdBEGo3HLus/pH2Sh4SlLfw+sAWcxtpYn
    9Mp0rc1Z4oHGLUmJ4M22X0LBKyP0+BzoYNhJfnGg7qP53mr/oZSMo4wFJiKkLWxp
    Ccy3LysdW2+CFiM8Mpl1RN6T/dNppJkNQ35ObbNpK4ikLjFtkdGt9rdjWQprZjcN
    SVtqv7Y6XQRzX+0c78WxSdDJDToLfoe5EcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021474; bh=cMP88SlrwVrRPUJ3452lVnEl5twt8I
    xQaU69p+GtL5c=; b=ZHwpiCkffAtdLtycsfJFb2ymwNQZvLjE9229TowmKcp2Na
    uwZtXDl9wPZLglkFeMTv7Z2+0UaX38SeViJVx8kIYAsOJE2duFJSIbcNvDJ5oCK/
    g8s5HqL4tOGVq7TazQOKvaM0FqJxGUTbNk3+WL7Ow0g9JDpVAUXJCAE4Gd1Wp9Qm
    C0KN0iMninXutcTILWxT/++CW16pJQhL0O40XAwYN6n7GSOCNRZeueim9w/JEOMj
    KoEAx9yp/Ar5XLDlZsbWNvB87Cg24daXHCsHDvI4T5pIcpO1WF8SeryKqFwGdVXn
    wl7X1KI05N5Ate76Ct1olx/AHJeHGa5VSZUZg92g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJXxULKB3rF0iuAdJHKP4nBo3L5cmIkzGRS5pF6ghg3tH5lLWbB/DH2N5Ns/XxvJ3PeiEjoIFWfKYV7qao5r3jrs3AiFs9vYnW8CwWVMRz/CrP9SI+9C
    43UIiBMEHdXFha0QOECziF+7o+dPM6qjK+Dam+a/lU8pTmrdofvq43qQSS02gHZ/38RqYilgXIYNOldPmClPL2zpZ/1vwWq6O4wt5fbSSkZ6N6y/5NezfTTK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=BTeA3XvPAAAA:8 a=jIQo8A4GAAAA:8 a=cm27Pg_UAAAA:8
    a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=1EsaE_6oAAAA:8 a=wn-MoGzFkvxOkHmv7jEA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=tafbbOV3vt1XuEhzTjGK:22 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=xmb-EsYY8bH0VWELuYED:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
    a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755052AbeDFNbH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:31:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755037AbeDFNbE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:31:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        John Youn <johnyoun@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chen Yu <chenyu56@huawei.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 44/72] usb: dwc2: Improve gadget state disconnection handling
Date: Fri,  6 Apr 2018 15:23:45 +0200
Message-Id: <20180406084308.925396942@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
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

From: John Stultz <john.stultz@linaro.org>

commit d2471d4a24dfbff5e463d382e2c6fec7d7e25a09 upstream.

In the earlier commit dad3f793f20f ("usb: dwc2: Make sure we
disconnect the gadget state"), I was trying to fix up the
fact that we somehow weren't disconnecting the gadget state,
so that when the OTG port was plugged in the second time we
would get warnings about the state tracking being wrong.

(This seems to be due to a quirk of the HiKey board where
we do not ever get any otg interrupts, particularly the session
end detected signal. Instead we only see status change
interrupt.)

The fix there was somewhat simple, as it just made sure to
call dwc2_hsotg_disconnect() before we connected things up
in OTG mode, ensuring the state handling didn't throw errors.

But in looking at a different issue I was seeing with UDC
state handling, I realized that it would be much better
to call dwc2_hsotg_disconnect when we get the state change
signal moving to host mode.

Thus, this patch removes the earlier disconnect call I added
and moves it (and the needed locking) to the host mode
transition.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Tested-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1385,7 +1385,6 @@ static void dwc2_conn_id_status_change(s
 		dwc2_core_init(hsotg, false, -1);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
-		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
@@ -1403,8 +1402,12 @@ static void dwc2_conn_id_status_change(s
 		if (count > 250)
 			dev_err(hsotg->dev,
 				"Connection id status change timed out\n");
-		hsotg->op_state = OTG_STATE_A_HOST;
 
+		spin_lock_irqsave(&hsotg->lock, flags);
+		dwc2_hsotg_disconnect(hsotg);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+
+		hsotg->op_state = OTG_STATE_A_HOST;
 		/* Initialize the Core for Host mode */
 		dwc2_core_init(hsotg, false, -1);
 		dwc2_enable_global_interrupts(hsotg);
