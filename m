Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C993C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5451821902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jxHBv9Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfBGMCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:02:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48130 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBGMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:02:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190207120253euoutp02dfa32b80005beb762e5c51eda199c56c~BE04frd_S1749017490euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 12:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190207120253euoutp02dfa32b80005beb762e5c51eda199c56c~BE04frd_S1749017490euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549540973;
        bh=xRplYe6/k+KXLGVJ1f9DiDQ2yQOcdpGL78LsT5esEug=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jxHBv9JsDjzklIAZAxaGCjxMQUSqhVcKjYoH6gqoWijFboYWpR783rrcMZ2dj2dCI
         NVJtVRStCNOU09xjLQFPxol0yVBX+feDyNm7+qV2biqkDKxZQdvLtsTuh2SE9yS3+V
         CsxN72E1TXcgJFBKtjw/actzzdWG1EDAm02pb/qE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207120252eucas1p2cb7f41925a5f111f81078190a19b721a~BE04II9Na0149501495eucas1p2X;
        Thu,  7 Feb 2019 12:02:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.1E.04294.C6E1C5C5; Thu,  7
        Feb 2019 12:02:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190207120251eucas1p2b877d3963a4e20b8bd29a9b00efa7b59~BE03USv9d0149501495eucas1p2W;
        Thu,  7 Feb 2019 12:02:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190207120251eusmtrp1d7526fa32576e51a4e30ec5ce862e178~BE03F6cyk1580815808eusmtrp10;
        Thu,  7 Feb 2019 12:02:51 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-82-5c5c1e6c1fcd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.EB.04284.B6E1C5C5; Thu,  7
        Feb 2019 12:02:51 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190207120251eusmtip1eead515d8f69a6802ac2718fc43c405c~BE02v9yvB1766517665eusmtip1j;
        Thu,  7 Feb 2019 12:02:51 +0000 (GMT)
Subject: Re: [PATCH] ata: macio: Use of_node_name_eq for node name
 comparisons
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8c6cc6a1-dd37-c8cb-c85e-bcc514360597@samsung.com>
Date:   Thu, 7 Feb 2019 13:02:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181205195050.4759-4-robh@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned0cuZgYg38TRC1W3+1ns5h/5Byr
        xbEdj5gsLu+aw2bxf88OdgdWj8tnSz02repk8/i8SS6AOYrLJiU1J7MstUjfLoErY23LEsaC
        iSwVy5/dYWtg3MfcxcjJISFgInHu6CqWLkYuDiGBFYwSj7pOs4MkhAS+MEp0N1ZAJD4zSkxs
        vMEC0/HhUgczRGI5o8SfE++gnPeMEj+PbWbrYuTgEBYIkDj4wgukQURAUeJ32zRWEJtZoFzi
        6ZNuJhCbTcBKYmL7KkYQm1fATmLq/lVgJ7EIqEjsfPWbGWSMqECERP8ZdYgSQYmTM5+wgIQ5
        gW44/psdYqKBxJFFc6Cmy0tsfzsH7BoJgWZ2iUUXT7BB3OwicfX7WlYIW1ji1fEt7BC2jMTp
        yT0sEA3TGSXe/FoK5axnlFhz5hgTRJW1xOHjF1lBNksIOErcby6BMPkkbrwVhFjMJzFp23Rm
        iDCvREebEESjmsSGZRvYYFZ17VwJDXQPidZD6xknMCrOQvLZLCTvzELyzgJG5lWM4qmlxbnp
        qcVGeanlesWJucWleel6yfm5mxiB6eP0v+NfdjDu+pN0iFGAg1GJhzfgVlSMEGtiWXFl7iFG
        CQ5mJRHeCKmYGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTByc
        Ug2MHKa3GmbfvRKpEbsgfep/t6On+J+tLD79++MO7S6Vj+r7xD+KSsxePUe3x0OvlEsg9Ix6
        w1LTkosFl3+EMDBNOrzkxW1/Jm2OFunAKA1GFUVb9c0XBBtm2swK695zSdzpWM3coLlF+/js
        9W85rgw51Jzc79ys8PV3zrTfWflMBfrWfsKzEi2VWIozEg21mIuKEwFxIIIjGwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Xd1suZgYgwVHpSxW3+1ns5h/5Byr
        xbEdj5gsLu+aw2bxf88OdgdWj8tnSz02repk8/i8SS6AOUrPpii/tCRVISO/uMRWKdrQwkjP
        0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY23LEsaCiSwVy5/dYWtg3MfcxcjJISFg
        IvHhUgeQzcUhJLCUUaLt0hHGLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZZRY1f2ICSQhLOAn8e7Z
        b7BBIgKKEr/bprGC2EIC7YwSV0/Zg8xhFiiXaDiSDBJmE7CSmNi+ihHE5hWwk5i6fxVYK4uA
        isTOVxBjRAUiJG497GCBqBGUODnzCQvIGE6gO4//ZgcJMwvoSey4/osVwpaX2P52DvMERsFZ
        SDpmISmbhaRsASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCo2Hbs5+YdjJc2Bh9iFOBg
        VOLhDbgVFSPEmlhWXJl7iFGCg1lJhDdCKiZGiDclsbIqtSg/vqg0J7X4EKMp0A8TmaVEk/OB
        EZtXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGxrHl2sPvuAJ3n
        y5w3r1b7YP4zK4SVqyOYpzP326MHM99VuG4/eWlF4T71vLvav1Nvbjje9d/a+dqC8+H+Xffu
        RYV1MrvMq7Sved2qcyrW9PnOpXOyhC2kdc4n/rE4tYJXweDvqf1TlWY/nbr2SrTsGxOlixOk
        jql9TOoLCtvB0h17/lP7VjFTJZbijERDLeai4kQA0Xv/jKACAAA=
X-CMS-MailID: 20190207120251eucas1p2b877d3963a4e20b8bd29a9b00efa7b59
X-Msg-Generator: CA
X-RootMTR: 20181205195131epcas3p3519c2452d1c90583338f098540e721ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205195131epcas3p3519c2452d1c90583338f098540e721ee
References: <CGME20181205195131epcas3p3519c2452d1c90583338f098540e721ee@epcas3p3.samsung.com>
        <20181205195050.4759-4-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/05/2018 08:50 PM, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
