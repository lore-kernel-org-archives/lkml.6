Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3737C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9832B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLFUhL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:37:11 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbeLFUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:37:10 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6Ka3Uu001259;
        Thu, 6 Dec 2018 21:37:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3uhn6j8b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Dec 2018 21:37:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B8B231;
        Thu,  6 Dec 2018 20:37:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBCDA5635;
        Thu,  6 Dec 2018 20:37:04 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 21:37:05 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 21:37:05 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH 6/7] remoteproc: fix trace buffer va initialization
Thread-Topic: [PATCH 6/7] remoteproc: fix trace buffer va initialization
Thread-Index: AQHUiCq0t7hbO4mVSE+fslvzku8PmaVyNaSA
Date:   Thu, 6 Dec 2018 20:37:05 +0000
Message-ID: <1a6e9b2e45c54d4183370e827e0e2891@SFHDAG7NODE2.st.com>
References: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
 <1543526968-56091-7-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1543526968-56091-7-git-send-email-loic.pallardy@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Loic PALLARDY
> Sent: jeudi 29 novembre 2018 22:29
> To: bjorn.andersson@linaro.org; ohad@wizery.com
> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org; s-anna@ti.com; Loic PALLARDY
> <loic.pallardy@st.com>
> Subject: [PATCH 6/7] remoteproc: fix trace buffer va initialization
> 
> With rproc_alloc_registered_carveouts() introduction, carveouts are
> allocated after resource table parsing.
> rproc_da_to_va() may return NULL at trace resource registering.
> This patch modifies trace debufs registering to provide device address
> (da) instead of va.
> da to va translation is done at each trace buffer access
> through debugfs interface.
> 
> Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry
> struct")
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 26 ++++++++++----------------
>  drivers/remoteproc/remoteproc_debugfs.c  | 21 +++++++++++++++++----
>  drivers/remoteproc/remoteproc_internal.h |  9 ++++++++-
>  3 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index f19bc6961e40..9dbcc16f8782 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -562,9 +562,8 @@ void rproc_vdev_release(struct kref *ref)
>  static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
>  			      int offset, int avail)
>  {
> -	struct rproc_mem_entry *trace;
> +	struct rproc_debug_trace *trace;
>  	struct device *dev = &rproc->dev;
> -	void *ptr;
>  	char name[15];
> 
>  	if (sizeof(*rsc) > avail) {
> @@ -578,28 +577,23 @@ static int rproc_handle_trace(struct rproc *rproc,
> struct fw_rsc_trace *rsc,
>  		return -EINVAL;
>  	}
> 
> -	/* what's the kernel address of this resource ? */
> -	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len);
> -	if (!ptr) {
> -		dev_err(dev, "erroneous trace resource entry\n");
> -		return -EINVAL;
> -	}
> -
>  	trace = kzalloc(sizeof(*trace), GFP_KERNEL);
>  	if (!trace)
>  		return -ENOMEM;
> 
>  	/* set the trace buffer dma properties */
> -	trace->len = rsc->len;
> -	trace->va = ptr;
> +	trace->trace_mem.len = rsc->len;
> +	trace->trace_mem.da = rsc->da;
> +
> +	/* set pointer on rproc device */
> +	trace->rproc = rproc;
> 
>  	/* make sure snprintf always null terminates, even if truncating */
>  	snprintf(name, sizeof(name), "trace%d", rproc->num_traces);
> 
>  	/* create the debugfs entry */
> -	trace->priv = rproc_create_trace_file(name, rproc, trace);
> -	if (!trace->priv) {
> -		trace->va = NULL;
> +	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> +	if (!trace->tfile) {
>  		kfree(trace);
>  		return -EINVAL;
>  	}
> @@ -608,8 +602,8 @@ static int rproc_handle_trace(struct rproc *rproc,
> struct fw_rsc_trace *rsc,
> 
>  	rproc->num_traces++;
> 
> -	dev_dbg(dev, "%s added: va %pK, da 0x%x, len 0x%x\n",
> -		name, ptr, rsc->da, rsc->len);
> +	dev_dbg(dev, "%s added: da 0x%x, len 0x%x\n",
> +		name, rsc->da, rsc->len);
> 
>  	return 0;
>  }

rproc_resource_cleanup() modification not included in this patch. (lost during rebase)
I'll post a v2.

Regards,
Loic

> diff --git a/drivers/remoteproc/remoteproc_debugfs.c
> b/drivers/remoteproc/remoteproc_debugfs.c
> index e90135c64af0..11240b4d0a91 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -47,10 +47,23 @@ static struct dentry *rproc_dbg;
>  static ssize_t rproc_trace_read(struct file *filp, char __user *userbuf,
>  				size_t count, loff_t *ppos)
>  {
> -	struct rproc_mem_entry *trace = filp->private_data;
> -	int len = strnlen(trace->va, trace->len);
> +	struct rproc_debug_trace *data = filp->private_data;
> +	struct rproc_mem_entry *trace = &data->trace_mem;
> +	void *va;
> +	char buf[100];
> +	int len;
> +
> +	va = rproc_da_to_va(data->rproc, trace->da, trace->len);
> +
> +	if (!va) {
> +		len = scnprintf(buf, sizeof(buf), "Trace %s not available\n",
> +				trace->name);
> +		va = buf;
> +	} else {
> +		len = strnlen(va, trace->len);
> +	}
> 
> -	return simple_read_from_buffer(userbuf, count, ppos, trace->va,
> len);
> +	return simple_read_from_buffer(userbuf, count, ppos, va, len);
>  }
> 
>  static const struct file_operations trace_rproc_ops = {
> @@ -288,7 +301,7 @@ void rproc_remove_trace_file(struct dentry *tfile)
>  }
> 
>  struct dentry *rproc_create_trace_file(const char *name, struct rproc
> *rproc,
> -				       struct rproc_mem_entry *trace)
> +				       struct rproc_debug_trace *trace)
>  {
>  	struct dentry *tfile;
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> index f6cad243d7ca..7d8936688164 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -25,6 +25,13 @@
> 
>  struct rproc;
> 
> +struct rproc_debug_trace {
> +	struct rproc *rproc;
> +	struct dentry *tfile;
> +	struct list_head node;
> +	struct rproc_mem_entry trace_mem;
> +};
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> @@ -37,7 +44,7 @@ void rproc_remove_virtio_dev(struct rproc_vdev
> *rvdev);
>  /* from remoteproc_debugfs.c */
>  void rproc_remove_trace_file(struct dentry *tfile);
>  struct dentry *rproc_create_trace_file(const char *name, struct rproc
> *rproc,
> -				       struct rproc_mem_entry *trace);
> +				       struct rproc_debug_trace *trace);
>  void rproc_delete_debug_dir(struct rproc *rproc);
>  void rproc_create_debug_dir(struct rproc *rproc);
>  void rproc_init_debugfs(void);
> --
> 2.7.4

