Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeBAPzS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:55:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752582AbeBAPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:55:13 -0500
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Rob Landley <rob@landley.net>, Arvind Sankar <nivedita@alum.mit.edu>
Cc: initramfs <initramfs@vger.kernel.org>,
        Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 10:55:00 -0500
In-Reply-To: <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
         <1517436423.3469.237.camel@linux.vnet.ibm.com>
         <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
         <20180201020331.GA3774@rani.riverdale>
         <1517458921.3329.2.camel@linux.vnet.ibm.com>
         <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020115-0012-0000-0000-000005AA6178
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020115-0013-0000-0000-000019260831
Message-Id: <1517500500.3974.45.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:

> > With your patch and specifying "root=tmpfs", dracut is complaining:
> > 
> > dracut: FATAL: Don't know how to handle 'root=tmpfs'
> > dracut: refusing to continue
> 
> [googles]... I do not understand why this package exists.
> 
> If you're switching to another root filesystem, using a tool that
> wikipedia[citation needed] says has no purpose but to switch to another
> root filesystem, (so let's reproduce the kernel infrastructure in
> userspace while leaving it the kernel too)... why do you need initramfs
> to be tmpfs? You're using it for half a second, then discarding it,
> what's the point of it being tmpfs?

Unlike the kernel image which is signed by the distros, the initramfs
doesn't come signed, because it is built on the target system.  Even
if the initramfs did come signed, it is beneficial to measure and
appraise the individual files in the initramfs.

> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
> is configured in, even when you're then going to overmount it with
> something else like you're doing, let's just _remove_ the test. If it
> can be tmpfs, have it be tmpfs.

Very much appreciated!

thanks,

Mimi
