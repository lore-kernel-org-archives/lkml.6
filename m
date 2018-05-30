Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeE3WAu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:00:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932222AbeE3WAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:00:49 -0400
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from
 "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Date: Wed, 30 May 2018 18:00:28 -0400
In-Reply-To: <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
         <15281606.YptaXzsEVL@x2>
         <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
         <3607733.4k8ofLVAdP@x2>
         <1160afb4-4184-b30c-5f67-c21536b5f7d3@linux.vnet.ibm.com>
         <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com>
         <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18053022-0016-0000-0000-000001D62191
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053022-0017-0000-0000-0000322896BD
Message-Id: <1527717628.3534.79.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 17:49 -0400, Stefan Berger wrote:
> 
> So the other choice is to only keep patches 1,2, 6, and 7, so leave most 
> of the integrity audit messages untouched. Then only create a different 
> format for the new AUDIT_INTEGRITY_POLICY_RULE (current 8/8) that shares 
> (for consistency reasons) the same format with the existing integrity 
> audit messages but also misses tty= and exe= ?

Another option would be for the new AUDIT_INTEGRITY_POLICY_RULE to
call audit_log_task_info() similar to what ima_audit_measurement()
does.

Mimi
