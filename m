Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeC0RFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:05:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753523AbeC0RE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:04:58 -0400
Date: Tue, 27 Mar 2018 19:04:51 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@schleppi
To: Christoph Hellwig <hch@lst.de>
cc: Jesper Nilsson <jesper.nilsson@axis.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dma_zalloc_coherent broken with
 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
In-Reply-To: <20180327164505.GA10522@lst.de>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi> <20180327143341.GA4968@lst.de> <alpine.LFD.2.21.1803271717580.26440@schleppi> <20180327164505.GA10522@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18032717-0008-0000-0000-000004E2E07C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032717-0009-0000-0000-00001E761BF4
Message-Id: <alpine.LFD.2.21.1803271900390.18934@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Christoph Hellwig wrote:
> On Tue, Mar 27, 2018 at 05:24:10PM +0200, Sebastian Ott wrote:
> > What do you mean by current implementations? Arch specific code? At least
> > on s390 we don't do that. dma-mapping.h doesn't do it either.
> 
> The arch implementations should do it.  Seems like s390 and potentially
> a few others don't.  I'm a little slow due to a cast on one arm, but I'll
> do an audit and will fix up anything I'll find.

What was wrong with the old behavior (let the caller decide - the same
as with memory allocations)? We have interfaces like dma_zalloc_coherent,
which explicitely set __GFP_ZERO. We have callers of dma_alloc followed by
a manually memset..

Sebastian
