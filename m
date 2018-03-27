Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeC0Il5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:41:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751686AbeC0Ilx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:41:53 -0400
Date: Tue, 27 Mar 2018 10:41:45 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@schleppi
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Christoph Hellwig <hch@lst.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma_zalloc_coherent broken with
 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
In-Reply-To: <CAMuHMdX_aTqi=8FmBR07K6-C=ycCrPQ+dT=ujXzNTcekdXB5ag@mail.gmail.com>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi>  <CAMuHMdX_aTqi=8FmBR07K6-C=ycCrPQ+dT=ujXzNTcekdXB5ag@mail.gmail.com>
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
x-cbid: 18032708-0020-0000-0000-0000040A39E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032708-0021-0000-0000-0000429E3B8E
Message-Id: <alpine.LFD.2.21.1803271037410.1726@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On Tue, 27 Mar 2018, Geert Uytterhoeven wrote:
> On Tue, Mar 27, 2018 at 10:12 AM, Sebastian Ott
> <sebott@linux.vnet.ibm.com> wrote:
> > commit 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7 broke usage of dma
> > allocations specifying __GFP_ZERO by silently removing that flag.
> 
> How did it break? The flag is now always added.

+       flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);

I read that as a removal. But maybe I need more coffee..

Sebastian
