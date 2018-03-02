Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2738277-1520030409-3-10006913716079828567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520030408; b=SVBG7QXD3Wwl9EwJ75JoVcJ34cUF1zmhrnGOxtpAtGeQkAC
    kVU5xa8DoYntjUMi3Z8H8/oIlJPivrh0tqI9y8pvbf+Bdb1cmssRjN/YCd+nYTtO
    mphlh7ev5DmxYYnHluJ8D8glUUjhIFutqU35xML4zhsrsHGHIermmDHm27sjo3kq
    XHLG6yZcydiuDhfR/2ldJ402PK8Al1OCvDKRi9OaG7G+c69gXgD/w4YnfNVv7juT
    hcBOU/U4to7FHSCBgDfew7gqaJzm3jiANR/P6cYqsfUqJeOkiCQwczrM2p15RNSA
    0cVdU+DgxJggPtGOfo+uFbFcv49h34nilJ0FMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520030408; bh=Hg4K4c
    y4zSy3jtcS0UB8X+rXviI+FXDCRoveUKxYYuM=; b=kNXxH/QAq7OuBRVAfv5yBR
    vjqyfP11QwNftkfznaVcFC0DwZ6XSykubs+XhKoyWehQHXc92NH3w/zDKQgtM8Hp
    ESKP5Pm4oLuSYbmqq5hu3prRRzkQbO8/B6v9V7O/BNoVclf97LJ+P7FDRpwoy4nv
    eFBiY80cg9QdrE6g9Y50I2EAqy3edz7Ydwgsknu4YJM8oAC3SqjC12gkASBABpgA
    58Noet8sG94kpbu48QDqJ8FWbWGmtHb1QZF8uKvW68/oe0arFd5PE9ypJtHtFvvc
    wjU7QTrXkwYjUdZ2cqf/OAwdLTYmCxRb5AKagenyq4gQUuIyVlXsGDVaKU2VG7lg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeCBWkF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 17:40:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932464AbeCBWkE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 17:40:04 -0500
X-UUID: 8e07f552cdc7463ba64c77219bbf7e86-20180303
Message-ID: <1520030090.8089.186.camel@mtkswgap22>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
From: Sean Wang <sean.wang@mediatek.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: <matthias.bgg@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>
Date: Sat, 3 Mar 2018 06:34:50 +0800
In-Reply-To: <20180302105719.GC27178@ulmo>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
         <20180302105719.GC27178@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-02 at 11:57 +0100, Thierry Reding wrote:
> On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > programming on PWM hardware causes waveform cannot be output as expected.
> > Thus, the patch adds the extra condition for fixing up the weird case to
> > let PWM4 or PWM5 able to work on MT7623.
> > 
> > v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> > v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Zhi Mao <zhi.mao@mediatek.com>
> > Cc: John Crispin <john@phrozen.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> [...]
> > @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
> > +		/*
> > +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> > +		 * from the other PWMs on MT7623.
> > +		 */
> > +		reg_width = PWM45DWIDTH_FIXUP;
> > +		reg_thres = PWM45THRES_FIXUP;
> > +	}
> 
> I don't understand this. According to the condition above the above
> would also use the PWM[4,5] "fixup" register offsets with PWM[3]. Should
> the condition be pwm->hwpwm > 3?
> 
> Thierry


PWM[4,5] are the naming specified in datasheet and kept it as is here
and driver or userspace would use index 3 and 4 to have a reference to
them respectively.
