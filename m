Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933062AbeE2KBT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:01:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933052AbeE2KBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:01:11 -0400
Date: Tue, 29 May 2018 13:00:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Colin King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211_hwsim: add error check to call to
 rhashtable_init
Message-ID: <20180529100049.up6wzjkzmd5a3v2q@mwanda>
References: <20180529091412.8530-1-colin.king@canonical.com>
 <1527585428.6955.7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527585428.6955.7.camel@sipsolutions.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=540
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:17:08AM +0200, Johannes Berg wrote:
> On Tue, 2018-05-29 at 10:14 +0100, Colin King wrote:
> > 
> > @@ -3573,7 +3573,9 @@ static int __init init_mac80211_hwsim(void)
> >  	hwsim_wq = alloc_workqueue("hwsim_wq", 0, 0);
> >  	if (!hwsim_wq)
> >  		return -ENOMEM;
> > -	rhashtable_init(&hwsim_radios_rht, &hwsim_rht_params);
> > +	err = rhashtable_init(&hwsim_radios_rht, &hwsim_rht_params);
> > +	if (err)
> > +		return err;
> 
> That's missing a workqueue free, but I can fix that while applying if
> you prefer.
> 

And we don't free the hashtable on error either.

regards,
dan carpenter
