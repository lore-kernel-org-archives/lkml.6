Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B5B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAVPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:43:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbfAVPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:43:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MFe2eS122333
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:43:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q65adjfav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:43:26 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 22 Jan 2019 15:43:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 15:43:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MFhLDL8192264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 15:43:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FE64203F;
        Tue, 22 Jan 2019 15:43:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EECF242041;
        Tue, 22 Jan 2019 15:43:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 15:43:19 +0000 (GMT)
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 22 Jan 2019 10:43:09 -0500
In-Reply-To: <CAOQ4uxjNhNFfFidjzi-8ywQPi54LdzT=LxwdSaX+H-ERS6Qwog@mail.gmail.com>
References: <1545158873.4206.86.camel@linux.ibm.com>
         <20190117213421.ggasuc263dpqh46c@merlin>
         <1548072003.3782.24.camel@linux.ibm.com>
         <CAOQ4uxjNhNFfFidjzi-8ywQPi54LdzT=LxwdSaX+H-ERS6Qwog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012215-0020-0000-0000-00000309E46C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012215-0021-0000-0000-0000215B1A49
Message-Id: <1548171789.4038.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 14:29 +0200, Amir Goldstein wrote:
> On Mon, Jan 21, 2019 at 2:00 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2019-01-17 at 15:34 -0600, Goldwyn Rodrigues wrote:
> > > On 13:47 18/12, Mimi Zohar wrote:
> > > > If tmpfiles can be made persistent, then newly created tmpfiles need to
> > > > be treated like any other new files in policy.
> > > >
> > > > This patch indicates which newly created tmpfiles are in policy, causing
> > > > the file hash to be calculated on __fput().
> > >
> > > Discussed in overlayfs, this would be better if we use this on inode
> > > and called from vfs_tmpfile() instead of do_tmpfile(). This will cover
> > > the overlayfs case which uses tmpfiles while performing copy_up().
> > > The patch is attached.
> > >
> > > Here is the updated patch which works for my cases.
> > > However, it is the the failure case after setting the IMA flags
> > > I am concerned about, though I don't think that should be as harmful.
> >
> > Right.  The new IMA hook allocates memory for storing the flags, which
> > needs to be cleaned up on failure.  For this reason, the IMA call is
> > deferred until after the transition from locally freeing memory on
> > failure to relying on __fput().  In "do_last", the call to IMA is
> > after "opened"; and in the original version of this patch the call to
> > IMA is after finish_open().
> >
> 
> Not sure I understand the concern.
> The integrity context is associated with the inode and will be freed
> on destroy_inode() no matter which error path is taken.
> Am I missing something?

No, as long as destroy_inode() is called, it should be fine.

thanks,

Mimi

