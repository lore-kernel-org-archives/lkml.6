Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA17C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1531206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0rxsp9lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1531206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeIMFfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:35:52 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:32889 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeIMFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:35:52 -0400
Received: by mail-pf1-f179.google.com with SMTP id d4-v6so1823405pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYTP+i6Nb8Ei8Y0iMv+E9xNuLMy4yM5vbYScmXiTZxc=;
        b=0rxsp9lR9mcPK2hoIXVUAB2yAKHqXD0got4r0YViSTZv+YPX2icRFwSoZ4+bU/yXGp
         QgpvtGElmC/pEd/cX2MWY6DfL6sXIkIhSQ4HHCN2soA0AfOIR0JUt+p62xyPMuj7c3qy
         lxFnFfPAW8vPQwJxPg6e+R9a+63MrjWB5jweyjaydvf+LrBwXaW0erytqmNlPUXvYq8v
         nlUekp4/N9MSG19f2TrDuYYplYWJsVF1AqapsD32BpYXy/6gQd5ikirYfFxDI6iEfb6i
         AKNz+/+3tNdYcevxiYvKnwH+aNuBfqaIHnzLTf/+qPUEu1MPrkRw1F6f131E021B4ozJ
         XhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYTP+i6Nb8Ei8Y0iMv+E9xNuLMy4yM5vbYScmXiTZxc=;
        b=Tm54zQScgPDwXDjWieudor92hngwt2H3wayQcBatOFIO/VZ3cEAjy2H1fBN/t5pxuQ
         hPsnj70GPrDd1GhbfjDRkdp+5L6mPv4XE1tqzec8t7RQuiokXg7gEOZUNnmqVYECdVUP
         7NuJydv5ZaxkRjLLGQGyIhseCDEOMFf+zPvwU80MCo+n8SaXpnGgQPsZ1TzgaWXGsDY9
         nm0KJV37VoM24pKQUYfZr2bneOF31cFYqurH1DlmldM6vvcVCBKYPSurv1E6adePNyLl
         aOSOXbfPdElxpALUHfNUxBhfdD9wMmBv4W+tq1tFej4iEgxDbYT1NcHN27yvF5So6SJI
         jjmQ==
X-Gm-Message-State: APzg51CI4kYTNg6EzvIpfYqXF/V42oiW4BHEccphzoBn4M0P/viTwxlv
        y0slAlR7afBu9hx6aTKZL1W8jg==
X-Google-Smtp-Source: ANB0VdZlSQNhOneFnB6BdlyhcicQ9zgj15gJxtcFaBW4dYw/m+gygFj2wY5LTI4xtI++GQ8M3P1bqg==
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr4798119pfe.3.1536798533985;
        Wed, 12 Sep 2018 17:28:53 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id z19-v6sm3211921pgi.33.2018.09.12.17.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 17:28:52 -0700 (PDT)
Subject: Re: [PATCH v6 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-8-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0118d3d8-a2f5-047f-6627-04ac3d0371ad@kernel.dk>
Date:   Wed, 12 Sep 2018 18:28:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180913001156.4115-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 6:11 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory.
> 
> When a request is submitted we check if PCI P2PDMA memory is assigned
> to the first page in the bio. If it is, we ensure the queue it's
> submitted to supports it, and enforce REQ_NOMERGE.

This changelog is no longer accurate.

-- 
Jens Axboe

