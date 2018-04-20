Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeDTJqD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:46:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754194AbeDTJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:46:02 -0400
Subject: Re: [PATCH] isci: Fix infinite loop in while loop
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 20 Apr 2018 11:45:51 +0200
In-Reply-To: <20180420090310.714-1-colin.king@canonical.com>
References: <20180420090310.714-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042009-8235-0000-0000-00000D576DB5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008888; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01020593; UDB=6.00520764; IPR=6.00799830;
 MB=3.00020682; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-20 09:46:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042009-8236-0000-0000-00004090A012
Message-Id: <1524217551.3321.4.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200096
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 10:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case when the phy_mask is bitwise anded with the
> phy_index bit is zero the continue statement currently jumps
> to the next iteration of the while loop and phy_index is
> never actually incremented, potentially causing an infinite
> loop if phy_index is less than SCI_MAX_PHS. Fix this by
> jumping to the increment of phy_index.
> 
> [ The goto is used to save one more level of nesting that
> makes the code far wider than 80 columns. ]

what's wrong with replacing the while() with a for() that just works
(removing the increment at the end).  This is effectively open coding a
for loop anyway, which is a pattern we wouldn't want replicated.

James
