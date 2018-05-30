Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeE3WPj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:15:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932447AbeE3WPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:15:36 -0400
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit"
 actions
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <15281606.YptaXzsEVL@x2>
 <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
 <3607733.4k8ofLVAdP@x2>
 <1160afb4-4184-b30c-5f67-c21536b5f7d3@linux.vnet.ibm.com>
 <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com>
 <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
 <1527717628.3534.79.camel@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 18:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527717628.3534.79.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18053022-0036-0000-0000-000002FDFD93
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040011; UDB=6.00530848; IPR=6.00819144;
 MB=3.00021384; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 22:15:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053022-0037-0000-0000-00004481B0B6
Message-Id: <b9b37328-2977-39fe-e3d2-822144dce6f1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 06:00 PM, Mimi Zohar wrote:
> On Wed, 2018-05-30 at 17:49 -0400, Stefan Berger wrote:
>> So the other choice is to only keep patches 1,2, 6, and 7, so leave most
>> of the integrity audit messages untouched. Then only create a different
>> format for the new AUDIT_INTEGRITY_POLICY_RULE (current 8/8) that shares
>> (for consistency reasons) the same format with the existing integrity
>> audit messages but also misses tty= and exe= ?
> Another option would be for the new AUDIT_INTEGRITY_POLICY_RULE to
> call audit_log_task_info() similar to what ima_audit_measurement()
> does.

Right. [That would mean keep 1,2, 7 and modify 8.] Is that the best 
solution?

>
> Mimi
