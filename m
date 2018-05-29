Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933108AbeE2KCA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:02:00 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:59786 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeE2KBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:01:53 -0400
Message-ID: <1527588104.6955.10.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: add error check to call to
 rhashtable_init
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Colin King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 12:01:44 +0200
In-Reply-To: <20180529100049.up6wzjkzmd5a3v2q@mwanda>
References: <20180529091412.8530-1-colin.king@canonical.com>
         <1527585428.6955.7.camel@sipsolutions.net>
         <20180529100049.up6wzjkzmd5a3v2q@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 13:00 +0300, Dan Carpenter wrote:
> On Tue, May 29, 2018 at 11:17:08AM +0200, Johannes Berg wrote:
> > On Tue, 2018-05-29 at 10:14 +0100, Colin King wrote:
> > > 
> > > @@ -3573,7 +3573,9 @@ static int __init init_mac80211_hwsim(void)
> > >  	hwsim_wq = alloc_workqueue("hwsim_wq", 0, 0);
> > >  	if (!hwsim_wq)
> > >  		return -ENOMEM;
> > > -	rhashtable_init(&hwsim_radios_rht, &hwsim_rht_params);
> > > +	err = rhashtable_init(&hwsim_radios_rht, &hwsim_rht_params);
> > > +	if (err)
> > > +		return err;
> > 
> > That's missing a workqueue free, but I can fix that while applying if
> > you prefer.
> > 
> 
> And we don't free the hashtable on error either.

Heh. Ok, I guess I'll make a whole new commit to fix up all the things
here.

johannes
