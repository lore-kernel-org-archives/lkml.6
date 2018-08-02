Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE61C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E883A21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E883A21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbeHBPbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:31:38 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:51069 "EHLO
        15.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbeHBPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:31:38 -0400
Received: from player698.ha.ovh.net (unknown [10.109.143.238])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4C928172E27
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 15:23:49 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id 898B75200B5;
        Thu,  2 Aug 2018 15:23:40 +0200 (CEST)
Date:   Thu, 2 Aug 2018 15:23:39 +0200
From:   Greg Kurz <groug@kaod.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH v2] net/9p/trans_virtio.c: add null
 terminal for mount tag
Message-ID: <20180802152339.194c2820@bahia.lan>
In-Reply-To: <5B62658A.3010605@huawei.com>
References: <5B6262F4.9080601@huawei.com>
        <20180802015439.GA27403@nautica>
        <5B62658A.3010605@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 424464266746960358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrleeggdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 09:59:38 +0800
piaojun <piaojun@huawei.com> wrote:

> Hi Dominique,
> 
> On 2018/8/2 9:54, Dominique Martinet wrote:
> > piaojun wrote on Thu, Aug 02, 2018:  
> >> chan->tag is Non-null terminated which will result in printing messy code
> >> when debugging code. So we should add '\0' for tag to make the code more
> >> convenient and robust. In addition, I drop char->tag_len to simplify the
> >> code.  
> > 
> > Some new lines in commit message would be appreciated.
> > 
> > That aside, I have a couple of nitpicks, but it looks good to me - thanks
> >   
> >>
> >> Signed-off-by: Jun Piao <piaojun@huawei.com>
> >> ---
> >>  net/9p/trans_virtio.c | 15 +++++----------
> >>  1 file changed, 5 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> >> index d422bfc..0fe9c37 100644
> >> --- a/net/9p/trans_virtio.c
> >> +++ b/net/9p/trans_virtio.c
> >> @@ -89,10 +89,8 @@ struct virtio_chan {
> >>  	unsigned long p9_max_pages;
> >>  	/* Scatterlist: can be too big for stack. */
> >>  	struct scatterlist sg[VIRTQUEUE_NUM];
> >> -
> >> -	int tag_len;
> >>  	/*
> >> -	 * tag name to identify a mount Non-null terminated
> >> +	 * tag name to identify a mount null terminated
> >>  	 */
> >>  	char *tag;
> >>
> >> @@ -529,10 +527,9 @@ static ssize_t p9_mount_tag_show(struct device *dev,
> >>  	vdev = dev_to_virtio(dev);
> >>  	chan = vdev->priv;
> >>
> >> -	memcpy(buf, chan->tag, chan->tag_len);
> >> -	buf[chan->tag_len] = 0;
> >> +	memcpy(buf, chan->tag, strlen(chan->tag) + 1);
> >>
> >> -	return chan->tag_len + 1;
> >> +	return strlen(chan->tag) + 1;  
> > 
> > Use a local variable for strlen(chan->tag)?
> >   
> Yes, local variable looks better.
> 
> >>  }
> >>
> >>  static DEVICE_ATTR(mount_tag, 0444, p9_mount_tag_show, NULL);
> >> @@ -585,7 +582,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> >>  		err = -EINVAL;
> >>  		goto out_free_vq;
> >>  	}
> >> -	tag = kmalloc(tag_len, GFP_KERNEL);
> >> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
> >>  	if (!tag) {
> >>  		err = -ENOMEM;
> >>  		goto out_free_vq;
> >> @@ -594,7 +591,6 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> >>  	virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
> >>  			   tag, tag_len);
> >>  	chan->tag = tag;
> >> -	chan->tag_len = tag_len;
> >>  	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
> >>  	if (err) {
> >>  		goto out_free_tag;
> >> @@ -654,8 +650,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> >>
> >>  	mutex_lock(&virtio_9p_lock);
> >>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
> >> -		if (!strncmp(devname, chan->tag, chan->tag_len) &&
> >> -		    strlen(devname) == chan->tag_len) {
> >> +		if (!strncmp(devname, chan->tag, strlen(chan->tag) + 1)) {  
> > 
> > strncmp(x, y, strlen(y)+1) is precisely what strcmp does so let's use
> > the simpler version
> >   
> strcmp looks simpler, and I will wait for a while to hear more
> suggestions, and then post another patch for these fixes.
> 

Nothing more to add. Please go ahead.

> Thanks,
> Jun
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer

