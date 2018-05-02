Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AB8JxZql+Jr4529oLV0smeSk3N5+yPJtwzRwgp8gK5/lPZ2poqMsLoyFlgDNEoOO2EEbJu7u+qAU
ARC-Seal: i=1; a=rsa-sha256; t=1525297122; cv=none;
        d=google.com; s=arc-20160816;
        b=zU+XW43ZJUHrBouxpqVe2oKpfunHddPg0Kx1zDqnuxu1V3+ItuIRFaPAUnB5u99wgb
         RlsxOYOdt+bNubSDTbYYylqtpJcE/25vcObHwEsj4JfOMW2rN/GIzhQgEM7XG3+RA8N5
         CRY6Ne3fDaZ/mzUl8mM3elvGcH0R8yG+Tm5xSV2US7bJusL46GfCPHyTi5GN+7O6iAb6
         Xrx38WPZUjV5rph1mMYc0Q1kEnFAFGoS2g0wB4xCbmLNLft4z8TT3s5BPR2sjWpyOIhp
         1msehv+kmWVmXkV5G3JvJrSgrduaV41zuvSk+tkDg+b9MFl+GWnist6NLPKNJvLW5AEi
         H6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=HQLljr6itk2vgjEnzthCAiJjzWSDi4/uFE4L1TVQEtw=;
        b=X3e04tovZrz4XwpmSuhoKRE7cuopH7Ki64eHYrW3Up3VCF4YZlWWtZFowsmeL0EJbL
         RSdjiSnfncJy6Irtxzcm5M9cOj3iBMMvi2o485aok47GjzNdO0vyGtBLWKV+jfWjiP74
         fFp1GtE6V8WzGX0diXRFVRFWjbNSVuIow8Rv9tMLKWnDOX4xU5auQ7q7bezuhgpjIi7y
         gvQ0q20rW9H5ZFByG8w1t/8fqs5qqr/UVgTkGUIqF+F/5fcbTkVCQ5/qaP1Bw2qJQkoP
         1pAoi2RCW5LWRlfAAN2InyqEzRlZuFNDvtQS/IlWdsNuPn0rnRW74IahVk7rulAT9F1u
         6ECw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=eFBSWq9o;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=eFBSWq9o;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To: Linus Walleij <linus.walleij@linaro.org>
Cc: x86@kernel.org, xen-devel@lists.xenproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, pbonzini@redhat.com, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, bp@suse.de,
        dave.hansen@linux.intel.com, "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kirill.shutemov@linux.intel.com,
        luto@kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Christoph Hellwig <hch@infradead.org>, roger.pau@citrix.com,
        rkrcmar@redhat.com
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <CACRpkdZNm54ukoggpta4o5XfALryHSO4Ptx0EhzNDG5HLLSSRw@mail.gmail.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <485951af-ebf4-33f9-d32c-a5e331f43884@oracle.com>
Date: Wed, 2 May 2018 14:37:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZNm54ukoggpta4o5XfALryHSO4Ptx0EhzNDG5HLLSSRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=857
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597946171029255726?=
X-GMAIL-MSGID: =?utf-8?q?1599389955609624324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 1:11 AM, Linus Walleij wrote:
> I wonder why I am starting to get CCed on Xen patches all of a sudden.
>
> I happened to run into Jürgen at a conference only last weekend, but
> I still don't know anything whatsoever about Xen or how it works.
>
> If get_maintainer.pl has started to return my name on this stuff I
> really want to know why :/

It has nothing to do with Xen actually. But for some reason, the 
get_maintainer.pl script is returning your name for any patch that 
modifies the MAINTAINERS file. Although why that is the case wasn't 
clear to me based on a quick look at both those files.

-Maran

> Yours,
> Linus Walleij
