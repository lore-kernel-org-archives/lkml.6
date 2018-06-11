Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 61F40C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A702208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A702208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeFKUsF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:48:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:40935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbeFKUsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:48:04 -0400
Received: from localhost ([92.75.47.185]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3AWN-1gHgZX0eoB-00srXA; Mon, 11
 Jun 2018 22:47:56 +0200
Date:   Mon, 11 Jun 2018 22:47:54 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] media: staging/imx: fill vb2_v4l2_buffer field
 entry
Message-ID: <20180611224754.1f4d3792@gmx.net>
In-Reply-To: <9d5ff49f-6d07-0371-9cc1-5ee929328241@gmail.com>
References: <20180315191323.6028-1-ps.report@gmx.net>
        <9d5ff49f-6d07-0371-9cc1-5ee929328241@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Uz4HUvjDpoucvyJBULEq4waQV4ozxMnw9UxMPNm7RzlCHJgvvFs
 Fe8xr83Xtctjoogu96FlFtBxwrX1r/aQo8j0AtC/R9dEElUc5+ZVcjs3/fuPTdpvYhUqHHz
 0pjT0F4JOkZ4rmaOI0vUdDvp5E+azPGMCWaMRZPqJsLIef3ty8OWvXFsOesla1fUZoigEg5
 yuc1FBUx2Be3zHHKh2Gag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U+WeIGfxbCg=:C/UoL2UnYgw5Ut9tMtMCi6
 p/Xka+6RZA5qhk9bbM25DFRqOS8tAoSsnu9aPXhHtKZva2srGmEg1RA2sduHSaWxmCp473xfV
 4d+SDjs0o11JS9e4wxk7T7ITcyw1lnwyiYC2XAbXmtUr4lN1aB/giSBmnq6XnzyW6TCOgFjd9
 QIfm9px49U4oogT6iOejed8MZh1aLyEwx5MAbWZsbL2uaruN7M7ghojuHleDo+cDTxKOOS24Q
 i7r7llY6+JuMMwVY44/BFIsKdkfBXGJymG6ELDvSN5I9/SadXWebIHy6SxQxq7GUCEmKzsxn+
 YeZlz45b1Dge8F0JcS3LQNRNHgkWILI0a202yUUIpBhLUrKxFtMhSPBw9aQ+lSYnL2moF94FQ
 bQmSMndD2aw/JtNFfC6h8FG3yRDlcozz7bZI7Izw6krKqXH0TJgO5nu5F7VP/WjudK/y7ylV1
 GD57cE+QZk6+g5HJr5O5vnGyGD5pei9ws/+3l9XGRudEbS/kWNQTbVyzpjue8H+TLs3LZrtzR
 YvLrScBoud1jVuoacj8FkpY8vNTDRN/gENcLrUFcOdr3wAMImOfMg+uFAM8nvrUxwM/Mvi0+e
 SNp4wrZj5jewW16WmNz3gDCBmQssDpsh9koPjS/KfMkmUxO3l2MFaEyEx4v+Mm6Ck5IS4v5hd
 iOAEGDvqwDUXlQ0cZK1QbZrXzM0FIDxsuQCZjaHUsW9Cx4Aja0YpacgLvGQyJ65P5IAjuob16
 rK1c8SSBZAMdBFrFGJ5MVnCAWzBhebTmXB27KnQRcqGoo7eq2LZwwjj1hLTN8Cn422aVV56QE
 UYyiZoO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

On Fri, 16 Mar 2018 10:02:47 -0700, Steve Longerbeam <slongerbeam@gmail.com> wrote:

> Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Ping? Anybody taking this one?

Regards,
Peter

> 
> 
> On 03/15/2018 12:13 PM, Peter Seiderer wrote:
> > - fixes gstreamer v4l2src warning:
> >
> >    0:00:00.716640334  349  0x164f720 WARN  v4l2bufferpool gstv4l2bufferpool.c:1195:gst_v4l2_buffer_pool_dqbuf:<v4l2src0:pool:src> Driver should never set v4l2_buffer.field to ANY
> >
> > - fixes v4l2-compliance test failure:
> >
> >    Streaming ioctls:
> >            test read/write: OK (Not Supported)
> >                Video Capture:
> >                    Buffer: 0 Sequence: 0 Field: Any Timestamp: 58.383658s
> >                    fail: v4l2-test-buffers.cpp(297): g_field() == V4L2_FIELD_ANY
> >
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> > Changes in v4:
> >    - new patch (put first because patch is needed to advance with
> >      the v4l2-compliance test), thanks to Philipp Zabel
> >      <p.zabel@pengutronix.de> for suggested solution for the right
> >      field value source
> > ---
> >   drivers/staging/media/imx/imx-ic-prpencvf.c | 1 +
> >   drivers/staging/media/imx/imx-media-csi.c   | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> > index ae453fd422f0..ffeb017c73b2 100644
> > --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> > +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> > @@ -210,6 +210,7 @@ static void prp_vb2_buf_done(struct prp_priv *priv, struct ipuv3_channel *ch)
> >   
> >   	done = priv->active_vb2_buf[priv->ipu_buf_num];
> >   	if (done) {
> > +		done->vbuf.field = vdev->fmt.fmt.pix.field;
> >   		vb = &done->vbuf.vb2_buf;
> >   		vb->timestamp = ktime_get_ns();
> >   		vb2_buffer_done(vb, priv->nfb4eof ?
> > diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> > index 5a195f80a24d..5f69117b5811 100644
> > --- a/drivers/staging/media/imx/imx-media-csi.c
> > +++ b/drivers/staging/media/imx/imx-media-csi.c
> > @@ -236,6 +236,7 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
> >   
> >   	done = priv->active_vb2_buf[priv->ipu_buf_num];
> >   	if (done) {
> > +		done->vbuf.field = vdev->fmt.fmt.pix.field;
> >   		vb = &done->vbuf.vb2_buf;
> >   		vb->timestamp = ktime_get_ns();
> >   		vb2_buffer_done(vb, priv->nfb4eof ?  
> 

