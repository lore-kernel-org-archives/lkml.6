Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeBZLQi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:16:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752157AbeBZLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:16:36 -0500
Date: Mon, 26 Feb 2018 12:16:28 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/17] Add kexec_file_load support to s390
In-Reply-To: <20180226012100.GA6019@linaro.org>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
        <20180214073543.GA12328@dhcp-128-65.nay.redhat.com>
        <20180214105449.1325bfbe@ThinkPad>
        <20180223083405.GA29498@dhcp-128-65.nay.redhat.com>
        <20180223110143.1747fb3f@ThinkPad>
        <20180224015956.GA11191@dhcp-128-65.nay.redhat.com>
        <20180226012100.GA6019@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022611-0016-0000-0000-00000529E70F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022611-0017-0000-0000-000028660E36
Message-Id: <20180226121628.5e832adf@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave
Hi AKASHI

On Mon, 26 Feb 2018 10:21:02 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > 
> > Arch code need arch maintainer to review, maybe either of you can send
> > the common part first before the arch code, eg. AKASHI can split the common
> >  cleanup patches and post them as a separate series, after these prep
> > series are reviewed then other patches can be refreshed based on it.
> > 
> > Seems in AKASHI's series, only patch 2, 3 ,4 ,5 is needed if split out
> > as a common change series.  
> 
> Yeah, all of those are touching kernel/kexec_file.c and in turn
> they can conflict if being applied with 390 patches, but none of changes
> that I made on kexec_file.c are overlapped with Phillips', I suppose
> that merging these two patch sets is rather straightforward.
> 
> @Phillips: I hope that your patch#14 and #17 be aligned with my patch#3
> as it is factoring out arch_kexec_{image_probe, image_load, verify_sig}()
> and arch_kimage_file_post_load_cleanup().

Splitting the common code patches from the series is totally fine with me.

On Friday I managed to get my code working with AKASHI's patches. After setting
ARCH_HAS_PURGATORY and cleaning up the kexec_* functions it worked basically out
of the box. However there is one problem with older compilers on s390. Please
see my comment on patch #3 for details.

Thanks
Philipp
