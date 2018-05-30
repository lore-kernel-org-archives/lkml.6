Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeE3MSF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:18:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753520AbeE3MRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:17:55 -0400
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity
 audits
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com>
 <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 08:17:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18053012-2213-0000-0000-000002B00B74
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039811; UDB=6.00532201; IPR=6.00818945;
 MB=3.00021374; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 12:17:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053012-2214-0000-0000-00005A4C4282
Message-Id: <0c9616fe-b404-eeed-1cba-c920c31694fd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 05:19 PM, Paul Moore wrote:
> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Use the new public audit functions to add the exe= and tty=
>> parts to the integrity audit records. We place them before
>> res=.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Suggested-by: Steve Grubb <sgrubb@redhat.com>
>> ---
>>   security/integrity/integrity_audit.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
>> index db30763d5525..8d25d3c4dcca 100644
>> --- a/security/integrity/integrity_audit.c
>> +++ b/security/integrity/integrity_audit.c
>> @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>>                  audit_log_untrustedstring(ab, inode->i_sb->s_id);
>>                  audit_log_format(ab, " ino=%lu", inode->i_ino);
>>          }
>> +       audit_log_d_path_exe(ab, current->mm);
>> +       audit_log_tty(ab, current);
> NACK
>
> Please add the new fields to the end of the audit record, thank you.

I put it there since Steve said '"res" is traditionally the last field 
in any event' (https://lkml.org/lkml/2018/5/22/539). I don't mind 
breaking with this tradition...

>
>>          audit_log_format(ab, " res=%d", !result);
>>          audit_log_end(ab);
>>   }
