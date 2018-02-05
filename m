Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeBERb4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:31:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753277AbeBERbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:31:49 -0500
Subject: Re: [PATCH] ima: define new policy condition based on the
 filesystem name
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        TarasKondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>, RobLandley <rob@landley.net>
Date: Mon, 05 Feb 2018 12:31:41 -0500
In-Reply-To: <20180115171914.GB28088@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
         <20180115162726.GB15686@infradead.org>
         <1516034407.6607.26.camel@linux.vnet.ibm.com>
         <20180115171914.GB28088@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020517-0008-0000-0000-000004C9A272
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020517-0009-0000-0000-00001E5D4C3D
Message-Id: <1517851901.3736.120.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-01-15 at 09:19 -0800, Christoph Hellwig wrote:
> On Mon, Jan 15, 2018 at 11:40:07AM -0500, Mimi Zohar wrote:
> > rootfs IS different than other filesystems, as other filesystems
> > uniquely identify the underlying filesystem type.  rootfs can be a
> > ramfs or tmpfs filesystem.  Only tmpfs supports xattrs.
> 
> Tons of filesystems only have xattrs optionally.  Check for goddamn
> xattrs if that is the requirement and not a name that has absolutely
> zero meaning for functionality.  That is the whole point!

I should have said the main reason for defining a rootfs policy rule
is not to differentiate it from ramfs, but the ability to require file
signatures.

Up to now, CPIO did not support xattrs.  With Taras' proposed CPIO
xattr patch set, the initramfs can now be properly labeled with file
signatures.  Since only some systems will include file signatures in
the initramfs, we need to be able to differentiate between those that
require file signatures from those that don't.

Mimi
