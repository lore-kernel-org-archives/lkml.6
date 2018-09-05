Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F61C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7625206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7625206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIENDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:03:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeIENDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:03:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13C703001500;
        Wed,  5 Sep 2018 08:34:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4591042558;
        Wed,  5 Sep 2018 08:34:24 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E96A718005CD;
        Wed,  5 Sep 2018 08:34:22 +0000 (UTC)
Date:   Wed, 5 Sep 2018 04:34:22 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-nvdimm@ml01.01.org, jack@suse.cz, stefanha@redhat.com,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, david@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com
Message-ID: <2039115539.10200490.1536136462488.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180904151700.GH17047@intel.com>
References: <20180904151700.GH17047@intel.com>
Subject: Re: [PATCH 3/3]  virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.193.198, 10.4.195.27]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: DhzJYxxBqsmf3Mkg2WfNr+8ca8eAgg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Sep 2018 08:34:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Thanks for the report.

> Hi Pankaj,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux-nvdimm/libnvdimm-for-next]
> [also build test ERROR on v4.19-rc2 next-20180903]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Pankaj-Gupta/kvm-fake-DAX-device/20180903-160032
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
> libnvdimm-for-next
> config: i386-randconfig-a3-201835 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> :::::: branch date: 21 hours ago
> :::::: commit date: 21 hours ago
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/virtio/virtio_pmem.o: In function `virtio_pmem_remove':
> >> drivers/virtio/virtio_pmem.c:220: undefined reference to
> >> `nvdimm_bus_unregister'
>    drivers/virtio/virtio_pmem.o: In function `virtio_pmem_probe':
> >> drivers/virtio/virtio_pmem.c:186: undefined reference to
> >> `nvdimm_bus_register'
> >> drivers/virtio/virtio_pmem.c:198: undefined reference to
> >> `nvdimm_pmem_region_create'
>    drivers/virtio/virtio_pmem.c:207: undefined reference to
>    `nvdimm_bus_unregister'

It looks like dependent configiguration 'LIBNVDIMM' is not enabled. I will add the 
dependency in Kconfig file for virtio_pmem in v2.

Thanks,
Pankaj

> 
> #
> https://github.com/0day-ci/linux/commit/acce2633da18b0ad58d0cc9243a85b03020ca099
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout acce2633da18b0ad58d0cc9243a85b03020ca099
> vim +220 drivers/virtio/virtio_pmem.c
> 
> acce2633 Pankaj Gupta 2018-08-31  147
> acce2633 Pankaj Gupta 2018-08-31  148  static int virtio_pmem_probe(struct
> virtio_device *vdev)
> acce2633 Pankaj Gupta 2018-08-31  149  {
> acce2633 Pankaj Gupta 2018-08-31  150  	int err = 0;
> acce2633 Pankaj Gupta 2018-08-31  151  	struct resource res;
> acce2633 Pankaj Gupta 2018-08-31  152  	struct virtio_pmem *vpmem;
> acce2633 Pankaj Gupta 2018-08-31  153  	struct nvdimm_bus *nvdimm_bus;
> acce2633 Pankaj Gupta 2018-08-31  154  	struct nd_region_desc ndr_desc;
> acce2633 Pankaj Gupta 2018-08-31  155  	int nid = dev_to_node(&vdev->dev);
> acce2633 Pankaj Gupta 2018-08-31  156  	struct nd_region *nd_region;
> acce2633 Pankaj Gupta 2018-08-31  157
> acce2633 Pankaj Gupta 2018-08-31  158  	if (!vdev->config->get) {
> acce2633 Pankaj Gupta 2018-08-31  159  		dev_err(&vdev->dev, "%s failure:
> config disabled\n",
> acce2633 Pankaj Gupta 2018-08-31  160  			__func__);
> acce2633 Pankaj Gupta 2018-08-31  161  		return -EINVAL;
> acce2633 Pankaj Gupta 2018-08-31  162  	}
> acce2633 Pankaj Gupta 2018-08-31  163
> acce2633 Pankaj Gupta 2018-08-31  164  	vdev->priv = vpmem =
> devm_kzalloc(&vdev->dev, sizeof(*vpmem),
> acce2633 Pankaj Gupta 2018-08-31  165  			GFP_KERNEL);
> acce2633 Pankaj Gupta 2018-08-31  166  	if (!vpmem) {
> acce2633 Pankaj Gupta 2018-08-31  167  		err = -ENOMEM;
> acce2633 Pankaj Gupta 2018-08-31  168  		goto out_err;
> acce2633 Pankaj Gupta 2018-08-31  169  	}
> acce2633 Pankaj Gupta 2018-08-31  170
> acce2633 Pankaj Gupta 2018-08-31  171  	vpmem->vdev = vdev;
> acce2633 Pankaj Gupta 2018-08-31  172  	err = init_vq(vpmem);
> acce2633 Pankaj Gupta 2018-08-31  173  	if (err)
> acce2633 Pankaj Gupta 2018-08-31  174  		goto out_err;
> acce2633 Pankaj Gupta 2018-08-31  175
> acce2633 Pankaj Gupta 2018-08-31  176  	virtio_cread(vpmem->vdev, struct
> virtio_pmem_config,
> acce2633 Pankaj Gupta 2018-08-31  177  			start, &vpmem->start);
> acce2633 Pankaj Gupta 2018-08-31  178  	virtio_cread(vpmem->vdev, struct
> virtio_pmem_config,
> acce2633 Pankaj Gupta 2018-08-31  179  			size, &vpmem->size);
> acce2633 Pankaj Gupta 2018-08-31  180
> acce2633 Pankaj Gupta 2018-08-31  181  	res.start = vpmem->start;
> acce2633 Pankaj Gupta 2018-08-31  182  	res.end   = vpmem->start +
> vpmem->size-1;
> acce2633 Pankaj Gupta 2018-08-31  183  	vpmem->nd_desc.provider_name =
> "virtio-pmem";
> acce2633 Pankaj Gupta 2018-08-31  184  	vpmem->nd_desc.module = THIS_MODULE;
> acce2633 Pankaj Gupta 2018-08-31  185
> acce2633 Pankaj Gupta 2018-08-31 @186  	vpmem->nvdimm_bus = nvdimm_bus =
> nvdimm_bus_register(&vdev->dev,
> acce2633 Pankaj Gupta 2018-08-31  187  						&vpmem->nd_desc);
> acce2633 Pankaj Gupta 2018-08-31  188  	if (!nvdimm_bus)
> acce2633 Pankaj Gupta 2018-08-31  189  		goto out_vq;
> acce2633 Pankaj Gupta 2018-08-31  190
> acce2633 Pankaj Gupta 2018-08-31  191  	dev_set_drvdata(&vdev->dev,
> nvdimm_bus);
> acce2633 Pankaj Gupta 2018-08-31  192  	memset(&ndr_desc, 0,
> sizeof(ndr_desc));
> acce2633 Pankaj Gupta 2018-08-31  193
> acce2633 Pankaj Gupta 2018-08-31  194  	ndr_desc.res = &res;
> acce2633 Pankaj Gupta 2018-08-31  195  	ndr_desc.numa_node = nid;
> acce2633 Pankaj Gupta 2018-08-31  196  	ndr_desc.flush = virtio_pmem_flush;
> acce2633 Pankaj Gupta 2018-08-31  197  	set_bit(ND_REGION_PAGEMAP,
> &ndr_desc.flags);
> acce2633 Pankaj Gupta 2018-08-31 @198  	nd_region =
> nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc);
> acce2633 Pankaj Gupta 2018-08-31  199
> acce2633 Pankaj Gupta 2018-08-31  200  	if (!nd_region)
> acce2633 Pankaj Gupta 2018-08-31  201  		goto out_nd;
> acce2633 Pankaj Gupta 2018-08-31  202
> acce2633 Pankaj Gupta 2018-08-31  203  	//virtio_device_ready(vdev);
> acce2633 Pankaj Gupta 2018-08-31  204  	return 0;
> acce2633 Pankaj Gupta 2018-08-31  205  out_nd:
> acce2633 Pankaj Gupta 2018-08-31  206  	err = -ENXIO;
> acce2633 Pankaj Gupta 2018-08-31  207  	nvdimm_bus_unregister(nvdimm_bus);
> acce2633 Pankaj Gupta 2018-08-31  208  out_vq:
> acce2633 Pankaj Gupta 2018-08-31  209  	vdev->config->del_vqs(vdev);
> acce2633 Pankaj Gupta 2018-08-31  210  out_err:
> acce2633 Pankaj Gupta 2018-08-31  211  	dev_err(&vdev->dev, "failed to
> register virtio pmem memory\n");
> acce2633 Pankaj Gupta 2018-08-31  212  	return err;
> acce2633 Pankaj Gupta 2018-08-31  213  }
> acce2633 Pankaj Gupta 2018-08-31  214
> acce2633 Pankaj Gupta 2018-08-31  215  static void virtio_pmem_remove(struct
> virtio_device *vdev)
> acce2633 Pankaj Gupta 2018-08-31  216  {
> acce2633 Pankaj Gupta 2018-08-31  217  	struct virtio_pmem *vpmem =
> vdev->priv;
> acce2633 Pankaj Gupta 2018-08-31  218  	struct nvdimm_bus *nvdimm_bus =
> dev_get_drvdata(&vdev->dev);
> acce2633 Pankaj Gupta 2018-08-31  219
> acce2633 Pankaj Gupta 2018-08-31 @220  	nvdimm_bus_unregister(nvdimm_bus);
> acce2633 Pankaj Gupta 2018-08-31  221  	vdev->config->del_vqs(vdev);
> acce2633 Pankaj Gupta 2018-08-31  222  	kfree(vpmem);
> acce2633 Pankaj Gupta 2018-08-31  223  }
> acce2633 Pankaj Gupta 2018-08-31  224
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
