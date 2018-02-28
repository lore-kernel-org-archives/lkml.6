Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935394AbeB1Wbh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:31:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935151AbeB1Wbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:31:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Feb 2018 16:31:37 -0600
From: wenxiong <wenxiong@linux.vnet.ibm.com>
To: wenxiong@linux.vnet.ibm.com
Cc: linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com,
        linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH V3] nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18022822-0048-0000-0000-000002422E11
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008604; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996501; UDB=6.00506612; IPR=6.00775823;
 MB=3.00019785; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 22:31:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022822-0049-0000-0000-00004449FEA0
Message-Id: <bf3a386a2b82dac84b681c14d5334632@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 14:05, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> With b2a0eb1a0ac72869c910a79d935a0b049ec78ad9(nvme-pci: Remove watchdog
> timer), EEH recovery stops working on ppc.
> 
> After removing whatdog timer routine, when trigger EEH on ppc, we hit
> EEH in nvme_timeout(). We would like to check if pci channel is offline
> or not at the beginning of nvme_timeout(), if it is already offline,
> we don't need to do future nvme timeout process.
> 
> Add mrmory barrier before calling pci_channel_offline().
> 
> With the patch, EEH recovery works successfuly on ppc.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Hi Keith and All,

We have the newer Linux distro releases came out recently, so I got more 
reports for this issue.

Test teams have verified the patch in several distro kernel 
version(v4.14, v4.15).


If you have any question about the V3 patch I submitted two weeks, Let 
me know.

Thanks,
Wendy
