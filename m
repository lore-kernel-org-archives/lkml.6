Return-Path: <kernel-hardening-return-12203-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELud7fGK05fILhL6DzQk83k7/NhS0DDp3r8jyCOOLr7UaUjfc68LR2VbRyuZP1UFW0vimc7h
ARC-Seal: i=1; a=rsa-sha256; t=1520444705; cv=none;
        d=google.com; s=arc-20160816;
        b=VvUtghr715JRx5v+Kzy/Wuj1fz+ErODCr6rWs+q/fuq0CoL5f1uWUjxrlao7Q04v4c
         kTEX9BCi+3+5kEQ9D9Lw2/NbCz2KIvtElXTz8acqQiX6nYUc57J1ax1/EcAOusOGEA+k
         Mxzg2VfsJW4CcuiJ8nsvFW1arvScv+BcEk9y9MBUFcDdoqMFKfcWNMbjJfaj34yVYTrI
         IazFqTrNOhY96LtoHY9yWbOrRGPFnr3wmMnsuK0As1bdLW0b3LBjAEjj2KQmMoibCCe+
         WwCxPciD7xNBHGKWCG7UJwKeakc8C3pWEs6Td/h6SA8nFwLu/hqMktOxxUJyQWEXWXZk
         WaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=WGRX3tnd+Ukzx6eKa4TGBoiok16xw+c6ROMU/LkwcFA=;
        b=ZQ8RS9wTRYN+ZTYNSOdINsjUxdxgU93H1tE5tyCX/4twSUffQFuego0rwVvJTZKSnt
         zWI1NjHgMtIvfgeKdsYBHY2i5FjPxp88Yw67RrhFx0Q+lU8973TDDexKYWKtovoQZncy
         jSm17eJ1Y3m6OiG1ajK8JbLihpFuHjP4lLo6seAo+1C3kgkTVNAyTT26hmA15IqKdjmP
         juZ6wJH+N1QrCvm2P/+0NSengCDnPKFLcJC0EXb5IYjg/V2KRgGd+bzoThGoUa9g120U
         YiXqjD6y5/6PAEcvJ4xg7EZ7H7bNrp7aXysp81ITjjkwHFU245D+mP8he5z0cLZqrUjO
         IZuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12203-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12203-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12203-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12203-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 07 Mar 2018 19:44:28 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <54e95716-9d61-51a3-9ae8-196e60625b76@huawei.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com> <20180228200620.30026-2-igor.stoppa@huawei.com> <20180306131856.GD19349@rapoport-lnx> <54e95716-9d61-51a3-9ae8-196e60625b76@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
To: Igor Stoppa <igor.stoppa@huawei.com>
CC: david@fromorbit.com, willy@infradead.org, keescook@chromium.org,
        mhocko@kernel.org, labbott@redhat.com,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
From: Mike Rapoprt <rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030717-0020-0000-0000-000003FFEC81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0021-0000-0000-000042942F21
Message-Id: <E69B22D6-8E5F-44EB-8C2B-C93960C08510@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070203
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594301827104376579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On March 7, 2018 4:48:25 PM GMT+02:00, Igor Stoppa <igor=2Estoppa@huawei=
=2Ecom> wrote:
>
>
>On 06/03/18 15:19, Mike Rapoport wrote:
>> On Wed, Feb 28, 2018 at 10:06:14PM +0200, Igor Stoppa wrote:
>
>[=2E=2E=2E]
>
>> If I'm not mistaken, several kernel-doc descriptions are duplicated
>now=2E
>> Can you please keep a single copy? ;-)
>
>What's the preferred approach?
>Document the functions that are API in the =2Eh file and leave in the =2E=
c
>those which are not API?

I aggree with Matthew: "we usually recommend putting it with the definitio=
n so it's more likely to be updated=2E"

I couldn't find the doc with this recommendation, though :)


>[=2E=2E=2E]
>
>>> + * The alignment at which to perform the research for sequence of
>empty
>>=20
>>                                            ^ search?
>
>yes
>
>>> + * get_boundary() - verifies address, then measure length=2E
>>=20
>> There's some lack of consistency between the name and implementation
>and
>> the description=2E
>> It seems that it would be simpler to actually make it get_length()
>and
>> return the length of the allocation or nentries if the latter is
>smaller=2E
>> Then in gen_pool_free() there will be no need to recalculate nentries
>> again=2E
>
>There is an error in the documentation=2E I'll explain below=2E
>
>>=20
>>>   * @map: pointer to a bitmap
>>> - * @start: a bit position in @map
>>> - * @nr: number of bits to set
>>> + * @start_entry: the index of the first entry in the bitmap
>>> + * @nentries: number of entries to alter
>>=20
>> Maybe: "maximal number of entries to check"?
>
>No, it's actually the total number of entries in the chunk=2E
>
>[=2E=2E=2E]
>
>>> +	return nentries - start_entry;
>>=20
>> Shouldn't it be "nentries + start_entry"?
>
>And in the light of the correct comment, also what I am doing should be
>now more clear:
>
>* start_entry is the index of the initial entry
>* nentries is the number of entries in the chunk
>
>If I iterate over the rest of the chunk:
>
>(i =3D start_entry + 1; i < nentries; i++)
>
>without finding either another HEAD or an empty slot, then it means I
>was measuring the length of the last allocation in the chunk, which was
>taking up all the space, to the end=2E
>
>Simple example:
>
>- chunk with 7 entries -> nentries is 7
>- start_entry is 2, meaning that the last allocation starts from the
>3rd
>element, iow it occupies indexes from 2 to 6, for a total of 5 entries
>- so the length is (nentries - start_entry) =3D (7 - 2) =3D 5
>
>
>But yeah, the kerneldoc was wrong=2E
>
>[=2E=2E=2E]
>
>>> - * gen_pool_alloc_algo - allocate special memory from the pool
>>> + * gen_pool_alloc_algo() - allocate special memory from the pool
>>=20
>> + using specified algorithm
>
>ok
>
>>=20
>>>   * @pool: pool to allocate from
>>>   * @size: number of bytes to allocate from the pool
>>>   * @algo: algorithm passed from caller
>>> @@ -285,14 +502,18 @@ EXPORT_SYMBOL(gen_pool_alloc);
>>>   * Uses the pool allocation function (with first-fit algorithm by
>default)=2E
>>=20
>> "uses the provided @algo function to find room for the allocation"
>
>ok
>
>--
>igor

--=20
Sincerely yours,
Mike=2E
