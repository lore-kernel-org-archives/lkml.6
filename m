Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBAEWK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 23:22:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751190AbeBAEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 23:22:09 -0500
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Arvind Sankar <nivedita@alum.mit.edu>, Rob Landley <rob@landley.net>
Cc: initramfs <initramfs@vger.kernel.org>,
        Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 31 Jan 2018 23:22:01 -0500
In-Reply-To: <20180201020331.GA3774@rani.riverdale>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
         <1517436423.3469.237.camel@linux.vnet.ibm.com>
         <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
         <20180201020331.GA3774@rani.riverdale>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020104-0040-0000-0000-0000040B28C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020104-0041-0000-0000-0000260EC69B
Message-Id: <1517458921.3329.2.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 21:03 -0500, Arvind Sankar wrote:
> On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
> > On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> > > On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I configured in tmpfs and am using rootfs but I want that
> > rootfs
> > >> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
> > >> it?)
> > > 
> > > I must be missing something.  Which systems don't specify "root=" on
> > > the boot command line.
> > 
> > Any system using initrd or initramfs?
> > 
> 
> Don't a lot of initramfs setups use root= to tell the initramfs which
> actual root file system to switch to after early boot?

With your patch and specifying "root=tmpfs", dracut is complaining:

dracut: FATAL: Don't know how to handle 'root=tmpfs'
dracut: refusing to continue

Mimi
