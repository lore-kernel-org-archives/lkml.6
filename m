Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbeCSP2U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:28:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755878AbeCSP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:28:12 -0400
Date: Mon, 19 Mar 2018 11:27:37 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180319152737.GK1110@char.us.oracle.com>
References: <20180319103826.12853-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319103826.12853-1-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 11:38:12AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the x86 code the the dma-direct implementation
> for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> getting rid of the special ops for the AMD memory encryption case and
> the STA2x11 SOC.  The generic implementations are based on the x86
> code, so they provide the same functionality.

I need to test this on my baremertal and Xen setup - and I lost your
git repo URL - any chance you mention point out to me so I can
kick of a build?

Thanks.

> 
> Changes since V2:
>  - minor changelog tweaks
>  - made is_sta2x11 a plain bool
> 
> Changes since V1:
>  - fix the length in the set_memory_decrypted call
>  - fix the SEV case
