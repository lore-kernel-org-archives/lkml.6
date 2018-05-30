Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeE3Tq5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:46:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932141AbeE3Tqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:46:53 -0400
Subject: Re: [PATCH 3/8] audit: Implement audit_log_tty()
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
 <CAHC9VhRjYhSgd_YCmgaOU_MEKuNKbHvPCVotmxyZRzSc2E6-Wg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 15:46:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRjYhSgd_YCmgaOU_MEKuNKbHvPCVotmxyZRzSc2E6-Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18053019-0052-0000-0000-000002F4DDDB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039961; UDB=6.00532309; IPR=6.00819094;
 MB=3.00021382; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 19:46:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053019-0053-0000-0000-00005CD62387
Message-Id: <38d49beb-a5dd-29de-3e4b-3dde67fdc28d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 05:07 PM, Paul Moore wrote:
> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>>
>> +void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk)
>> +{
>> +       struct tty_struct *tty = audit_get_tty(tsk);
>> +
>> +       audit_log_format(ab, " tty=%s", tty ? tty_name(tty) : "(none)");
>> +       audit_put_tty(tty);
>> +}
> Perhaps I missed it, but your IMA patches only ever call this to log
> current's tty, yes?  If so, I would prefer if we dropped the
> task_struct argument and always had audit_log_tty() use current.

Done.


>
