Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeDQKC1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:02:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751927AbeDQKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:02:24 -0400
Subject: Re: usercopy whitelist woe in scsi_sense_cache
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: David Windsor <dave@nullcore.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
Date: Tue, 17 Apr 2018 11:02:08 +0100
In-Reply-To: <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
         <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
         <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
         <2864697.7uzmEJovl2@natalenko.name>
         <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
         <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
         <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
         <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
         <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041710-0012-0000-0000-0000160E3E42
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008870; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019158; UDB=6.00519913; IPR=6.00798399;
 MB=3.00020614; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 10:02:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041710-0013-0000-0000-00005252D917
Message-Id: <1523959328.3250.11.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 20:12 -0700, Kees Cook wrote:
> I still haven't figured this out, though... any have a moment to look
> at this?

Just to let you know you're not alone ... but I can't make any sense of
this either.  The bfdq is the elevator_data, which is initialised when
the scheduler is attached, so it shouldn't change.  Is it possible to
set a data break point on elevator_data after it's initialised and see
if it got changed by something?

James
