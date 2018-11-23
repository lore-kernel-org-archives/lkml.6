Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8D420989
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8D420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441403AbeKXGQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:16:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441386AbeKXGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:16:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wANJSmW6094033
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:31:14 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nxkwy13xc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:31:14 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 23 Nov 2018 19:31:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 23 Nov 2018 19:31:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wANJV6It57671862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 19:31:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C01A405C;
        Fri, 23 Nov 2018 19:31:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6F6A4060;
        Fri, 23 Nov 2018 19:31:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.87.216])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Nov 2018 19:31:03 +0000 (GMT)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com
Date:   Fri, 23 Nov 2018 14:30:53 -0500
In-Reply-To: <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
         <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112319-0020-0000-0000-000002ECD5D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112319-0021-0000-0000-0000213C1AF9
Message-Id: <1543001453.4298.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-23_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811230162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 11:03 -0800, Casey Schaufler wrote:
> On 11/22/2018 7:49 AM, Roberto Sassu wrote:
> > Although rootfs (tmpfs) supports xattrs, they are not set due to the
> > limitation of the cpio format. A new format called 'newcx' was proposed to
> > overcome this limitation.
> >
> > However, it looks like that adding a new format is not simple: 15 kernel
> > patches; user space tools must support the new format; mistakes made in the
> > past should be avoided; it is unclear whether the kernel should switch from
> > cpio to tar.
> >
> > The aim of this patch is to provide the same functionality without
> > introducing a new format. The value of xattrs is placed in regular files
> > having the same file name as the files xattrs are added to, plus a
> > separator and the xattr name (<filename>.xattr-<xattr name>).
> >
> > Example:
> >
> > '/bin/cat.xattr-security.ima' is the name of a file containing the value of
> > the security.ima xattr to be added to /bin/cat.
> >
> > At kernel initialization time, the kernel iterates over the rootfs
> > filesystem, and if it encounters files with the '.xattr-' separator, it
> > reads the content and adds the xattr to the file without the suffix.
> 
> No.
> 
> Really, no.
> 
> It would be incredibly easy to use this mechanism to break
> into systems.
>  
> 
> > This proposal requires that LSMs and IMA allow the read and setxattr
> > operations. This should not be a concern since: files with xattr values
> > are not parsed by the kernel; user space processes are not yet executed.
> >
> > It would be possible to include all xattrs in the same file, but this
> > increases the risk of the kernel being compromised by parsing the content.
> 
> The kernel mustn't do this.

Mustn't do what?  Store the xattr as separate detached files, 
include all the xattrs in a single or per security/LSM xattr attribute
file(s), or either?

Mimi

