Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21213C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DDB20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DDB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeIFOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:22:37 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43696 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeIFOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:22:37 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fxqtH-0001v2-EK; Thu, 06 Sep 2018 11:47:55 +0200
Message-ID: <1536227267.4015.2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix TX status reporting for ieee80211s
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yuan-Chi Pang <fu3mo6goo@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Sep 2018 11:47:47 +0200
In-Reply-To: <1536227104.68915.5.camel@gmail.com> (sfid-20180906_114516_051319_173379BB)
References: <1535963610.3437.10.camel@sipsolutions.net>
         <1536224269-69350-1-git-send-email-fu3mo6goo@gmail.com>
         <1536227104.68915.5.camel@gmail.com> (sfid-20180906_114516_051319_173379BB)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 17:45 +0800, Yuan-Chi Pang wrote:
> 
> I received the comment of my previous submission that I should fix
> indentation. But if I use the same indentation as before, I got "line
> over 80 characters" warning by checkpatch. What should I do?
> 
> > diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
> > index daf9db3..4286673 100644
> > --- a/net/mac80211/mesh_hwmp.c
> > +++ b/net/mac80211/mesh_hwmp.c
> > @@ -295,15 +295,11 @@ int mesh_path_error_tx(struct
> > ieee80211_sub_if_data *sdata,
> >  }
> >  
> >  void ieee80211s_update_metric(struct ieee80211_local *local,
> > -		struct sta_info *sta, struct sk_buff *skb)
> > +		struct sta_info *sta, struct ieee80211_tx_status
> > *st)

Here? Seems easy - add a linebreak between sta and status?

johannes
