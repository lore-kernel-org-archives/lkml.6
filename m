Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163018AbeCAXZs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:25:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162908AbeCAXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:25:46 -0500
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Date: Fri, 02 Mar 2018 10:25:34 +1100
In-Reply-To: <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
         <1519936477.4592.23.camel@au1.ibm.com>
         <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
         <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
         <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
         <1519945204.4592.45.camel@au1.ibm.com>
         <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030123-0012-0000-0000-000005B7A917
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030123-0013-0000-0000-00001933AFAF
Message-Id: <1519946734.4592.48.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 16:19 -0700, Logan Gunthorpe wrote:
> 
> On 01/03/18 04:00 PM, Benjamin Herrenschmidt wrote:
> > We use only 52 in practice but yes.
> > 
> > >   That's 64PB. If you use need
> > > a sparse vmemmap for the entire space it will take 16TB which leaves you
> > > with 63.98PB of address space left. (Similar calculations for other
> > > numbers of address bits.)
> > 
> > We only have 52 bits of virtual space for the kernel with the radix
> > MMU.
> 
> Ok, assuming you only have 52 bits of physical address space: the sparse 
> vmemmap takes 1TB and you're left with 3.9PB of address space for other 
> things. So, again, why doesn't that work? Is my math wrong

The big problem is not the vmemmap, it's the linear mapping.

Cheers,
Ben.
