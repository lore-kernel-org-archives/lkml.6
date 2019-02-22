Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AD4206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBVUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:53:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbfBVUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:53:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MKmrgr045649
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:53:01 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qtr658ych-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:53:01 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 22 Feb 2019 20:53:00 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Feb 2019 20:52:52 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1MKqp1f28770484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 20:52:51 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04A79C605A;
        Fri, 22 Feb 2019 20:52:51 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B503BC6059;
        Fri, 22 Feb 2019 20:52:43 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.132.183])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Feb 2019 20:52:43 +0000 (GMT)
References: <20190214213729.21702-1-brendanhiggins@google.com> <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com> <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com> <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird\, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit testing framework
In-reply-to: <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
Date:   Fri, 22 Feb 2019 17:52:37 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19022220-0016-0000-0000-00000987DD8B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010645; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164891; UDB=6.00608353; IPR=6.00945479;
 MB=3.00025701; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-22 20:52:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022220-0017-0000-0000-0000423D8695
Message-Id: <871s3zeeay.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Frank Rowand <frowand.list@gmail.com> writes:

> On 2/19/19 10:34 PM, Brendan Higgins wrote:
>> On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> <snip>
>>> I have not read through the patches in any detail.  I have read some of
>>> the code to try to understand the patches to the devicetree unit tests.
>>> So that may limit how valid my comments below are.
>>
>> No problem.
>>
>>>
>>> I found the code difficult to read in places where it should have been
>>> much simpler to read.  Structuring the code in a pseudo object oriented
>>> style meant that everywhere in a code path that I encountered a dynamic
>>> function call, I had to go find where that dynamic function call was
>>> initialized (and being the cautious person that I am, verify that
>>> no where else was the value of that dynamic function call).  With
>>> primitive vi and tags, that search would have instead just been a
>>> simple key press (or at worst a few keys) if hard coded function
>>> calls were done instead of dynamic function calls.  In the code paths
>>> that I looked at, I did not see any case of a dynamic function being
>>> anything other than the value it was originally initialized as.
>>> There may be such cases, I did not read the entire patch set.  There
>>> may also be cases envisioned in the architects mind of how this
>>> flexibility may be of future value.  Dunno.
>>
>> Yeah, a lot of it is intended to make architecture specific
>> implementations and some other future work easier. Some of it is also
>> for testing purposes. Admittedly some is for neither reason, but given
>> the heavy usage elsewhere, I figured there was no harm since it was
>> all private internal usage anyway.
>>
>
> Increasing the cost for me (and all the other potential code readers)
> to read the code is harm.

Dynamic function calls aren't necessary for arch-specific
implementations either. See for example arch_kexec_image_load() in
kernel/kexec_file.c, which uses a weak symbol that is overriden by
arch-specific code. Not everybody likes weak symbols, so another
alternative (which admitedly not everybody likes either) is to use a
macro with the name of the arch-specific function, as used by
arch_kexec_post_alloc_pages() in <linux/kexec.h> for instance.

--
Thiago Jung Bauermann
IBM Linux Technology Center

