Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeECVmM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751195AbeECVmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:42:10 -0400
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Patrick Callaghan <patrickc@us.ibm.com>
Date: Thu, 03 May 2018 17:42:00 -0400
In-Reply-To: <alpine.LRH.2.21.1805040311050.12843@namei.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1805040311050.12843@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050321-0008-0000-0000-000004F2B903
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050321-0009-0000-0000-00001E86E241
Message-Id: <1525383720.3539.76.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-04 at 03:11 +1000, James Morris wrote:
> On Wed, 2 May 2018, Mehmet Kayaalp wrote:
> 
> > These patches add support for modifying the reserved space for extra
> > certificates in a compressed bzImage in x86. This allows separating the
> > system keyring certificate from the kernel build process. After the kernel
> > image is distributed, the insert-sys-cert script can be used to insert the
> > certificate for x86.
> 
> Can you provide more explanation of how this is useful and who would use 
> it?

I'm involved in a number projects that rely on a kernel build group to
actually build kernels for their systems.  Reserving memory for
additional public keys, allows product groups to insert public keys
post build.  Initially the product groups might insert development
keys, but eventually they would insert the product's public key.

Mimi
