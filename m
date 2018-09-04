Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF692086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LDqzS9Pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF692086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeIDMVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:21:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:21:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w847s4de136185;
        Tue, 4 Sep 2018 07:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=+oMCoao0zulnlMU2aSZRrMMBwELOLGqK5pPOEryTBHQ=;
 b=LDqzS9Pm13gMp1Ao1VFNYxA79KCoRjeZsCU4PNJi46+NkYpk3nUZ0PjDROOEp1EL8YSi
 PailTk7+3Gam3bPG0nYWCooDO3DUMTLkcUMniZcGc688WoM7pbIHK7TcCQk0K7G4KUSV
 tCIs5GlY/1zcT+QpjsTBrsDqMxDeNlyUgKDstm+052WRo0Qe24WoC9vdvMeThstbI0ll
 jqqD1WiOwJt0hn/wfTBC2Y08/A7WnwllUmuX2v2GJ8eWyJU9KZyXdZhSALZZxROcBETh
 /PoyJZo6MuxmRmowhp+dPt46C/oWIRt+1gZkvkRFcIDc/x94YgjV1GLj6bVbeQX8P6em Mg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpbahf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 07:57:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w847v62H014847
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 07:57:06 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w847v5bw029815;
        Tue, 4 Sep 2018 07:57:05 GMT
Received: from ravellos-mbp.lan (/87.214.231.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 00:57:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
From:   Nikita Leshenko <nikita.leshchenko@oracle.com>
In-Reply-To: <20180901124811.591511876@intel.com>
Date:   Tue, 4 Sep 2018 09:57:01 +0200
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peng DongX <dongx.peng@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <37B30FD3-7955-4C0B-AAB5-544359F4D157@oracle.com>
References: <20180901112818.126790961@intel.com>
 <20180901124811.591511876@intel.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9005 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=718
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Sep 2018, at 13:28, Fengguang Wu <fengguang.wu@intel.com> wrote:
> +static ssize_t ept_idle_read(struct file *file, char *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = file->private_data;
> +	struct ept_idle_ctrl *eic;
> +	unsigned long hva_start = *ppos << BITMAP_BYTE2PVA_SHIFT;
> +	unsigned long hva_end = hva_start + (count << BITMAP_BYTE2PVA_SHIFT);
> +	int ret;
> +
> +	if (*ppos % IDLE_BITMAP_CHUNK_SIZE ||
> +	    count % IDLE_BITMAP_CHUNK_SIZE)
> +		return -EINVAL;
> +
> +	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
> +	if (!eic)
> +		return -EBUSY;
> +
> +	eic->buf = buf;
> +	eic->buf_size = count;
> +	eic->kvm = task_kvm(task);
> +	if (!eic->kvm) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
I think you need to increment the refcount while using kvm,
otherwise kvm can be destroyed from another thread while you're
walking it.

-Nikita
> +
> +	ret = ept_idle_walk_hva_range(eic, hva_start, hva_end);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = eic->bytes_copied;
> +	*ppos += ret;
> +out_free:
> +	kfree(eic);
> +
> +	return ret;
> +}
