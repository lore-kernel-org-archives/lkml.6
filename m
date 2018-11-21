Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ADEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FB21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7FB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeKVDBP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:01:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729727AbeKVDBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:01:15 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 51591CA9E518A;
        Wed, 21 Nov 2018 16:26:04 +0000 (GMT)
Received: from FRAEMA701-CHM.china.huawei.com (10.206.14.50) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 16:26:00 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.76]) by
 FRAEMA701-CHM.china.huawei.com ([169.254.1.146]) with mapi id 14.03.0415.000;
 Wed, 21 Nov 2018 17:25:54 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Liuzhongzhu <liuzhongzhu@huawei.com>
Subject: RE: [PATCH net-next 3/8] net: hns3: Add "FD flow table" info query
 function
Thread-Topic: [PATCH net-next 3/8] net: hns3: Add "FD flow table" info query
 function
Thread-Index: AQHUgE3A88LCBPWoOUeZn/zB+IRylaVXnaeAgALN3fA=
Date:   Wed, 21 Nov 2018 16:25:54 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFC86CE@FRAEML521-MBX.china.huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
        <20181119211845.23168-4-salil.mehta@huawei.com>
 <20181119143045.5a147396@cakuba.netronome.com>
In-Reply-To: <20181119143045.5a147396@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.54]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacub,

> From: Jakub Kicinski [mailto:jakub.kicinski@netronome.com]
> Sent: Monday, November 19, 2018 10:31 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> lipeng (Y) <lipeng321@huawei.com>; mehta.salil@opnsrc.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Liuzhongzhu <liuzhongzhu@huawei.com>
> Subject: Re: [PATCH net-next 3/8] net: hns3: Add "FD flow table" info
> query function
> 
> On Mon, 19 Nov 2018 21:18:40 +0000, Salil Mehta wrote:
> > diff --git
> a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
> > new file mode 100644
> > index 000000000000..be7d0dea06e7
> > --- /dev/null
> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
> > @@ -0,0 +1,12 @@
> > +*************** int hclge_set_vlan_filter(struct hnae3_handle
> *handle, __be16 proto,
> > +*** 800,803 ****
> > +  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
> > +  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
> > +  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
> > +  #endif
> > +--- 800,804 ----
> > +  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
> > +  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
> > +  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
> > ++ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
> > +  #endif
> 
> You probably don't need this.

Goodness! I was on a transit while I floated this patch-set, somehow
missed my quick review. Sorry for this and thanks for catching!

Best regards
Salil
