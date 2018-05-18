Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZqTz5Wm5A950kbm7y5LkqMTwE7J/mKmHMu8PVsaw3c3F8785pyyMO96wsRT7Ph2aD9gJF5V
ARC-Seal: i=1; a=rsa-sha256; t=1526657398; cv=none;
        d=google.com; s=arc-20160816;
        b=R5utE8koQ7v5Ujzw2TOcJQPO1gNmlLrybe1JiZPzpVZuIW7/QSlvNbnY3HBX0JSqoq
         mQo1xahyOo2U1MKLKILgL43aAVRIwEVmJYWa9IHFeWYUSRur1FJYA7zeISdpJo3YsZw8
         vIK9Dygy+gtGLKpWGuewYA/D9uKcX2MUiesZwoAHCf2yluGKvg308vJ+yyTehN0vQfNt
         nIH/x8dKyOUf5TlpYtFbZPV6KXouJU4xYjjbEtR9n/CgBcPpHbh2BOWtqnCkqechsKm7
         9ncvuwcGnBDFn0sHu0M+D2wweZIt+2RWytSwOZIyhWNsS8tk5xJL/udDt9eagN/668bs
         NmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=8LD6LVm2quMqLLCYvmSiZPKmIyVfVQgEH4DpUt/eALg=;
        b=n1pfzH+w68MN01VQK1wcRfgcltGrs6PLd/JHczJlSm1iHdTzT2fnPNtQulayT/Q5c7
         vxrAUUpQNwIg+p1trzIYA54rdDiOVSRvUj3mdmBjcn2qg4YZ3HH7wFG+hTdVXsTzwbqS
         geeG84/VaGg8662IPGQXQ5eh2qQbXmWUgJJHnofetwUosuuPuiOFz6Dh/biMum1HcAUc
         k2gZbQcwt2TSmv/u6gDPO8yPxRhkTTNVCMk7pYL9Pk1wtpUvbNYd7/4pLWUYXFOc64tq
         MigTrPZTN/sdBGCNMSwTOsVzI+btvAKuX94xbD4Sy1Ihe1o3YIuKVC8OiUTmrLJ14346
         M63g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman"
	 <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R
 . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres
 Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 18 May 2018 11:29:36 -0400
In-Reply-To: <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	 <87y3ghhbws.fsf@xmission.com>
	 <1526643050.3632.127.camel@linux.vnet.ibm.com>
	 <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051815-0008-0000-0000-000004F7F77C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051815-0009-0000-0000-00001E8C75AC
Message-Id: <1526657376.3404.15.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180170
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600816308167994194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-18 at 07:58 -0700, Casey Schaufler wrote:
> On 5/18/2018 4:30 AM, Mimi Zohar wrote:

> > Having to define a separate LSM hook for each of the original, non
> > kernel_read_file(), buffer based method callers, kind of makes sense,
> > as the callers themselves are specific, but is it really necessary?
> > Could we define a new, generic LSM hook named
> > security_kernel_buffer_data() for this purpose?
> 
> If there are two disparate behaviors wrapped into kernel_read_file()
> Eric (bless him) is right. It should be broken into two hooks. I think
> that if we look (too) carefully we'll find other places where hooks
> should get broken up, or combined*. My question is just how important
> is it that this gets changed?

Other than the LSM call in copy_module_from_user(), this patch set is
adding the LSM call in kexec_load() and firmware_fallback_sysfs().

Eric, the question remains whether we need distinct LSM hooks in each
of these places or can we have a single, generic LSM hook named
security_kernel_buffer_data()?

Mimi
