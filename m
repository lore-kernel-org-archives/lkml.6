Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeFEJIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:08:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751510AbeFEJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:08:38 -0400
Date: Tue, 5 Jun 2018 14:38:27 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Abhishek <huntbag@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
 <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
 <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18060509-0028-0000-0000-000002CD4704
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060509-0029-0000-0000-000023844A77
Message-Id: <20180605090827.u535p5du5em3kgil@aksadiga.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050110
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:24:39PM +0530, Abhishek wrote:
> 
> 
> On 06/04/2018 05:15 PM, Akshay Adiga wrote:
> > On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
> > > Is this a new property ? I'm not fan of adding yet another of those
> > > silly arrays.
> > > 
> > > I would say this is the right time now to switch over to a node per
> > > state instead, as we discussed with Vaidy.
> 
> It is not a new property. Name was being used for description as description
> was not present in device tree. A skiboot patch adding description to device
> tree have been posted. This patch reads those description instead of copying
> name itself into description. And we fall back to reading name into
> description to not break the comaptibility with older firmware.

>From a cpuidle point of view this is a exisiting property, but for
powernv there was no device-tree property describing this. 

Abhishek has added the following skiboot patch for adding description
for each idle state in device-tree .
https://patchwork.ozlabs.org/patch/924879/

I agree this can go into new device tree format which each idle state
as a node. Probably i will roll this patch into mine in the next
version.


> 
> Thanks
> Abhishek
> 
> > I posted  the node based device tree here :
> > skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
> > kernel patch : https://lkml.org/lkml/2018/5/30/1146
> > 
> > Do you have any inputs for this design ?
> > 
> > > Additionally, while doing that, we can provide the versioning mechanism
> > > I proposed so we can deal with state specific issues and erratas.
> > > 
> > > Cheers,
> > > Ben.
> > > 
> 
