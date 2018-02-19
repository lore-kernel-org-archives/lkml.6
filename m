Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x225HjzHsgkVPIZOuHBPcxEaZRabLGFPYs2YJEcVcCS+RnlZs6rs8VMV/8c5n1kTXUXsskDkp
ARC-Seal: i=1; a=rsa-sha256; t=1519347659; cv=none;
        d=google.com; s=arc-20160816;
        b=HgVYBJb7oHzlw3VyeF9m1VmwyT1KoYUmwVTfETbbUEvonbbyDyyo4xk4LTRiaGZeWG
         Rg4PUaN+guqrZhtq+4/DqJx2AB2ds1Jb+nmBN53eurEEuzw6HGgNrj0gOiPQIhZc1xmR
         nl4l2q+zYgdgEmUnkj3ErAEagdKk29Mp+Zh3GSMoF9byN/NkthNLGIhY5uh3AzgX8zrZ
         7x2H4wTYjB/FmO6S3mpiNcvFOzWlLtKOi3qaxYE9ASM0dXz66hmumcNsLo2Mr68IwOyE
         vbljrPpSj3y3BpCWEZPNTFOacvBPtLCgfyoNwJpH9c6fNY3PtrTyF/AKd3rvHRifgrlZ
         LpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=QMuatbNyBKF0S0DVjWE1HE8GNup3SZVkMEpqcDBXv10=;
        b=DsX6/hKGnJe73TP6NEus2Vg5OdxWAhzx7uMHeprGvFEX0IxqjWFw5PWRCqrU6lvJ8W
         EbgEItbj4mAllVwBVrDOvEIYaPbWKiZE8MC99IVT0U8nwd+0QquDLglbLNjlcwrlFJIA
         xP/7gKsjdMGqhgPeXgWYPgHCufAcA/QGi/uToG07dalXwZrgTUjubYlvX6kjL8NehD4F
         p7NwK6zmNH6sHj2CGu4OMvO9kVjCoKanumJ2YUU9fOVP7ijbdhwECuK/cegr/SqEcxcr
         5+4idSma0CQ6pw0Kr46RP2wyixuKSpER22XJZCb88WZ+8foLMOpr9VkR5r0bkXEid2rz
         9GIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qnrqScaA;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qnrqScaA;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180219123932.GF21134@dhcp22.suse.cz>
Date: Mon, 19 Feb 2018 14:30:36 +0000
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kangmin Park <l4stpr0gr4m@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90E01411-7511-4E6C-BDDF-74E0334E24FC@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219082649.GD21134@dhcp22.suse.cz>
 <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
 <20180219123932.GF21134@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230009
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1593151491559722608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 19 Feb 2018, at 12:39, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Mon 19-02-18 12:14:26, Robert Harris wrote:
>>=20
>>=20
>>> On 19 Feb 2018, at 08:26, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> On Sun 18-02-18 16:47:55, robert.m.harris@oracle.com wrote:
>>>> From: "Robert M. Harris" <robert.m.harris@oracle.com>
>>>>=20
>>>> __fragmentation_index() calculates a value used to determine =
whether
>>>> compaction should be favoured over page reclaim in the event of =
allocation
>>>> failure.  The calculation itself is opaque and, on inspection, does =
not
>>>> match its existing description.  The function purports to return a =
value
>>>> between 0 and 1000, representing units of 1/1000.  Barring the case =
of a
>>>> pathological shortfall of memory, the lower bound is instead 500.  =
This is
>>>> significant because it is the default value of =
sysctl_extfrag_threshold,
>>>> i.e. the value below which compaction should be avoided in favour =
of page
>>>> reclaim for costly pages.
>>>>=20
>>>> This patch implements and documents a modified version of the =
original
>>>> expression that returns a value in the range 0 <=3D index < 1000.  =
It amends
>>>> the default value of sysctl_extfrag_threshold to preserve the =
existing
>>>> behaviour.
>>>=20
>>> It is not really clear to me what is the actual problem you are =
trying
>>> to solve by this patch. Is there any bug or are you just trying to
>>> improve the current implementation to be more effective?
>>=20
>> There is not a significant bug.
>>=20
>> The first problem is that the mathematical expression in
>> __fragmentation_index() is opaque, particularly given the lack of
>> description in the comments or the original commit message.  This =
patch
>> provides such a description.
>>=20
>> Simply annotating the expression did not make sense since the formula
>> doesn't work as advertised.  The fragmentation index is described as
>> being in the range 0 to 1000 but the bounds of the formula are =
instead
>> 500 to 1000.  This patch changes the formula so that its lower bound =
is
>> 0.
>=20
> But why do we want to fix that in the first place? Why don't we simply
> deprecate the tunable and remove it altogether? Who is relying on =
tuning
> this option. Considering how it doesn't work as advertised and nobody
> complaining I have that feeling that it is not really used in wild=E2=80=
=A6

I think it's a useful feature.  Ignoring any contrived test case, there
will always be a lower limit on the degree of fragmentation that can be
achieved by compaction.  If someone takes the trouble to measure this
then it is entirely reasonable that he or she should be able to inhibit
compaction for cases when fragmentation falls below some correspondingly
sized threshold.

I hope to improve upon the decison-making strategy in the allocator slow
path but that is not a short term goal.  The current patch is an
improvement for the interim.

Robert Harris=
