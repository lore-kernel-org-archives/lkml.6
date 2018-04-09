Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeDIOaK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:30:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752588AbeDIOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:30:07 -0400
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com
Date: Mon, 09 Apr 2018 10:29:58 -0400
In-Reply-To: <20180407103610.GA22542@linux.intel.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
         <20180405101210.GA21636@linux.intel.com>
         <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
         <20180407103610.GA22542@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040914-0040-0000-0000-0000042C2AE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040914-0041-0000-0000-000026303623
Message-Id: <1523284198.16421.196.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 13:36 +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 06, 2018 at 02:03:37PM +0530, Nayna Jain wrote:
> > On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> > > On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> > > > Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> > > > handle the TPM2_RC_RETRY error. The loop retries the command after
> > > > sleeping for the specified time, which is incremented exponentially in
> > > > every iteration. This patch fixes the initial sleep to be the default
> > > > sleep time.
> > > I think I understand the code change but do not understand what the
> > > long description.
> > 
> > It tells that the first sleep is delay_msec * 2 and not delay_msec.
> 
> So the problem is that the loop doubles the time before sleeping
> for the first time. This is missing from the description. Please
> refine it in some way.

Sure, how about replacing the last line of the patch description with:
    Unfortunately, the loop doubles the time before sleeping, causing the
    initial sleep to be doubled.  This patch fixes the initial sleep time.

If this change is acceptable, do you want to make the change or should Nayna repost the patch?

thanks,

Mimi
