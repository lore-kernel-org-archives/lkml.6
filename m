Return-Path: <prvs=6609069660=ast@fb.com>
X-Google-Smtp-Source: AG47ELsCWV6VLCTSFAG2eNEIwZE3XaGEAfaSUrrdqgPsxfyPk4asI9P1ygGyYlsexTx9tW7PtTu6
ARC-Seal: i=1; a=rsa-sha256; t=1520875434; cv=none;
        d=google.com; s=arc-20160816;
        b=RxDzz5aFtZjNwnHx3qvUyQTWhexTlSXENO6LWBje9FOATcXHatSzKHYc1yJW+X/5+w
         M1gS9TiynHxWh4KXgco/DSCpUT3q9V30+Jlm1o2UJhxJ+qmEK94hFbjVCenxmeXNRN9n
         WKBDaTEbeqoNJ0HO4Ka1wwGm69CqCHraS6JvsGzhmdYOx1uUtcUGzNRK1ecHYal9lDbO
         pqVXL2cjkb++IZiDcdHZxUDcc6HBbY1xgS8mVc1sLGtgansAlkWUn8V14jEGnS1iuDaR
         d7elys4Iuj4YrDCnP3BF0f5h3A1VSKR5J8eVFagSp9zXIuH3HGa9k9ZE881XXUTaDc/L
         rGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=zdrnzzUgElWtwxF8zBwL7PHqs4gh9RQg/CFvSJC5CbM=;
        b=mWGC/iemcltJl2bo1KoaSbl/SR2efgSP2bXJdD4OhmOd6WkDdJPlwJdesDBAx0Nlbv
         G3blQclo2U4LWmcHO9KF8PdMaymt6xVeKWsqq/b828j0CqurrcLTaMtMa4PPMBubkm/V
         ligkHWG38Ai1fnLlmJejT2zlqdOSYyct2Za1/YRZVvUw1+//MImQkcV/tzNPFwZ45VhJ
         IScuLNY8ncg3D68KVXocDEO8fN+gcBoaOCMXg6ni/oltnHyIkRUrssMUiCPjfd2jqpaw
         8So8q0lvxbj62Ol9WNeoExjWWF7g+m25ZP1lEtUJGqJ3/uQVrauyEMGpmTrez1dk98e4
         +NAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=T6kNr9Uy;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=GntvZUa+;
       spf=pass (google.com: domain of prvs=6609069660=ast@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=6609069660=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=T6kNr9Uy;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=GntvZUa+;
       spf=pass (google.com: domain of prvs=6609069660=ast@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=6609069660=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de> <20180310151652.GV4449@wotan.suse.de>
 <20180310153431.GW4449@wotan.suse.de>
CC: Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>, David Miller <davem@davemloft.net>,
        Andy
 Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team
	<kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <1f3e2c92-1e09-cc77-3b90-e33d7da35a2f@fb.com>
Date: Mon, 12 Mar 2018 10:22:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180310153431.GW4449@wotan.suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:e6ca]
X-ClientProxiedBy: DM5PR1601CA0008.namprd16.prod.outlook.com
 (2603:10b6:4:5e::21) To BN7PR15MB2500.namprd15.prod.outlook.com
 (2603:10b6:406:87::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2714d44-1ae9-4905-f5eb-08d5883dc76c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2500;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;3:9jMdKsDhPQN9IWfLp3kg22u4Zqf1xd0bNemlFXKsAoWXYtJeSYRkZ3E74wI5iksFIV7E3pAttRkg1XMYvKI+jEz7meZ6dnl4vWOvaKVEuApjVfCcUw4x/8hJ0IsBuOkg+ovJNqf8oH/ttMBBuQm4y4GRg8cKBBKPcEaYOXcmjXmODcgJwgP9B2HA9XiRIOENBqvkj2Qu6VS5ptfvkygCHXuDHcOo8raPhvqM5v9jz0yycbmk0eIaKM3XBZI34KOa;25:Po0LnbZ99l/1dK30qFJHkXDi9zay8oYLZhjNsGp2kUuDSCGTMoD9IoW2K6rDVMTwKYy+V8IrhfGduqI2zkMfIfBPz/8MR6BjbBRldJRlENPA+WY8fFCAvEQjgQVXQ3oTNBMKbZcxmmIGeie4jZXzlsK3Y2AYhRVeaRN6lWUYbn0MDpYw84NjzPvrb3vN7SYa/OXTKVSEuULHB7275Ea9gTF4srJWsj753y8gjy1Vnh6LGv6oSb5oIOdbXTcUdJoiMamhokNR7RMNfgXexZPXN4YzhYg8Qv1xh1tsNi/BVD0LiT4GFG0+vTX3mExLnWSknp8LcHZZjUtM6bIPoaOlrQ==;31:9vIO2wT8L8l4s9eCvGZ6ZT79OeRApvngSj97zbnqVBxMJroj+fhMzfdUa2RZOsZzh5eFl10nfiZ/ui8KTa4xjzHUCYqeQvhldG0E5vqJbK+9mI2XruXOLA0ywaAoJCthU+p1mTTaT6Jt0KFguR9vZRzeqXx6RZF5yI+YaMPaw9wMZy/JoVWhjK+sKhzDSz7NEhdGV/m/xX2Mh6bj4Ray47GpcST7e/hKbLf1avkwE8s=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2500:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;20:VvW0bOBK8uCEqJ3tUFQAJdLYCcetrYWaEnx2DWaYP8d4vaXKEtB8817D5MyelwTCq+kwZ0mUlOdBhHN+NYaU33cUHS35pA08SXfcH7+0Pizs8BUkDAa/8Yi0wVTgq4SUy5TgljgXwqFx4Gu/sNeMIfuAKU4L4TThOyn3W6xUj7nXWpH5RYyBY/ezILSsk2/+fzoKkAwYCvsPsUgYOqRgNYPmxuqBOtZoZHE8PlfU2+JOgnD6PtPlkbVgckGU1FFJV2vhs30DgbbzSru1503gXL9m0EbhjzkSIxIrzK67iYy8/8qYjidN31DRk6RpclHzgOimoCGRDITeU7MTm6S5R6GtNqsnNoDgi4NRMdFa4lW7t3WtBi5twJ2nFGZWgHee3V3MxmqTuMFm8L8HEpg+2L1Ipr3gjQlelpsrM2nYtrOA8KZrP5WRj1g//yjmphayQMOzGCU2/dYRgOmwXLqZv5dpoZCd9h0B3VgmshIRYUmw4v3g6uao824Iy192BP9b;4:xI92Mex7NK2zYUTmiNHqIw6dAXG9DXc1A7jy7SF3N/YNwWFCev/uwLivv6HlFxrJzh5zn9OR/eYbkqM/SB53vvwZkesBkBA9zO4PgUuylIdHYiDUVrngtNTtIDMFzoglRE72C52nCinYy28Almk1s/8VLaiUnNM6Qu31DkjOiAlhqk895EzWNzz0ggs5h6E1/XYjzdoyZ1J3p0Ys3sFlPUZ8YzUGb+PZV119Ujvn0V4DoPWME3eG2BBryhvRBn7q98+Uv8PAGAXRsb+gR5qxNQ==
X-Microsoft-Antispam-PRVS: <BN7PR15MB2500FE154E98173EF03D45C1D7D30@BN7PR15MB2500.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN7PR15MB2500;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2500;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(199004)(189003)(2906002)(386003)(4326008)(23746002)(97736004)(46003)(93886005)(53546011)(50466002)(39060400002)(65806001)(65956001)(230700001)(47776003)(81166006)(478600001)(81156014)(59450400001)(64126003)(7416002)(8676002)(105586002)(5660300001)(25786009)(54906003)(316002)(58126008)(53936002)(1706002)(8936002)(7736002)(106356001)(76176011)(65826007)(52116002)(186003)(31696002)(6666003)(31686004)(6246003)(229853002)(305945005)(68736007)(2950100002)(6486002)(36756003)(16526019)(6116002)(6916009)(67846002)(52396003)(86362001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2500;H:[IPv6:2620:10d:c081:1131::1375];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN7PR15MB2500;23:gUFojlJhyqQ+L5JMUM2vp93PMfzvq3gbJoHqM?=
 =?Windows-1252?Q?9eo0jD7oo0Rs+zrgXFVF6tAvWkkn5/vVLB+VNWpnb9zWdUFSlv8dfe8v?=
 =?Windows-1252?Q?g90mKjrrbRAq4hgUnjbackYGA1EUbENr1Bj0uWvEwwEWjgEzwB25NrIL?=
 =?Windows-1252?Q?sy36otHiR54RHOS1xIX/3sDfhdYQxl9PqLDVxyBQ5v48hnWNTGT0wPU1?=
 =?Windows-1252?Q?AaEAm6VmaE3Qe4z7lqtfG3Pk1wnlmW2vjJoUPuuPXX6tiyZVfTLDwiWm?=
 =?Windows-1252?Q?X0MbYlcT5MmC2F+Dtcz7exLUvKPs+Z/zcOU7daZ2ldkVTLbvdPpO+49e?=
 =?Windows-1252?Q?FJ7tmem6J1q2H8YX+niOJGUU39m4TuBuny/89ocu6KAPF2FhRkhEBxkR?=
 =?Windows-1252?Q?HrEoCYiyeTloavorBLWK9X3+gAIQHEmREuIopaD9xRtEwNz0Z5q7ti2q?=
 =?Windows-1252?Q?hu/jRsMhHGZUaB8ayzRKIv5VS3iaNp2E6PZXRJ7YZOJI3yxKn03IXD0C?=
 =?Windows-1252?Q?7IRnxXIoInYCE2CSG38at2gw99aEaUY1nOsaMWwJsF/9PgnomHxcd/5w?=
 =?Windows-1252?Q?g87NoBvUuPAnuZwFtKdoIQUkfj0irPJdZSYJrGNBqxQ0DZo8TVAPAkAX?=
 =?Windows-1252?Q?XXC3oCp+/wtOComaF85+45+0ozt+CeSY7frvMNz1k1HBOy/lcgFuZbSv?=
 =?Windows-1252?Q?jiZBZ93myLoy0U+koo4GyksgvPqNnxOZchvHoKR+8qNiGYxZn82C8QO1?=
 =?Windows-1252?Q?qEhyGtx12KglVKKiNKDxZQlndTktI0z3bmf9jHAbPke8v1nI79OcvQYj?=
 =?Windows-1252?Q?s1WQlcEgxGH6T8kvsJFCie8GY5KV076fy2wiFi5WVw6vB4fq/02MpSU/?=
 =?Windows-1252?Q?TyyNhe0vukeLMsAkNChOkk8PBxVZVqoE/qcds92bsmRAN8efwbwVvUzs?=
 =?Windows-1252?Q?oq4N/3SjZH3diCDsUVNVAMfN2U6Ico3HPHoScYnAf7F+D/4l8bfy1N6R?=
 =?Windows-1252?Q?MAkcSRzPpegtHgl0xnzHgFplEwadPd7HhTDCVqS16WaJkMxARmKDMNxC?=
 =?Windows-1252?Q?VTl/aI87/Yozj1bx7kgRtVzdQ2pN/0dfwfyzs+3yBf41TepSxoJeMwBK?=
 =?Windows-1252?Q?zBLZd7FUS5JW2TDjfzawLmXlG6se8KJpEYUysHwBTyPSkHoLXR25Jjpm?=
 =?Windows-1252?Q?MnhxP/4sCToN3GGd3v75HTSu47Y9BUzsFq+pyCotLTvdgTqoBc62pJKw?=
 =?Windows-1252?Q?6MZ0/3L7Q7dwZshks9v8Qv9SRTCt18pXHT4vYI36esYN6wXb5CBOxkJj?=
 =?Windows-1252?Q?TMe6SnnhjZARhlfszJJEIDIZQcO1u+JI8PxnmZA81JDCB9MFIzdTZUkE?=
 =?Windows-1252?Q?GZoC+NqX9+eUqMYIWmLTV+neXKblqM35kBzvQFfyZB0vgssbueK80B92?=
 =?Windows-1252?Q?grUvFweIuH/5HXluioOpZRdv1KAANjfRT0fgAsXCMfiuLSSm4gsiBZt4?=
 =?Windows-1252?Q?G8cQqVxUi/lCsRZ1yRTMdDGOipc?=
X-Microsoft-Antispam-Message-Info: LQ9oPPs2I7LRZGMl76HpDNcDvz69V7nX2REIYjegsQhhnK3JcWbi+awc+tOKOe8EnWQjdX0LeSl4RjoLxmGwIoWNNU3qFue9lsNUe4pX8cIM3UmQxRN+rqquRMCmBPpXW78keqRgfnd2rEPTKnOfmqSryvHKhYe3e9pFgjgrxVOZdTdUlnamT2oFQFcNXIsA
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;6:3wGHcFuQdciRkvN+dn3DS7g+2Zn2GUjiSilD66d9/x/K4DEHFuPELfl2XbSPBwm5DYeS/zaoI1tGshgzFpAbNEjK+ygJBYd7qnKX7rHRqzMGTcLp6IJ3PHySq500vWNL1GjjNso2AHRTv80MiKhZGKgqGicXVLKdMKUmlKoMsvm4h1VHOTExuoea19JywOeyv56euHSaCuGzaEvzeRT5Vv7z0imnYGgbfkEmdFcY+Ou0wq3YcIoCU8m0ThkMhAHM96zSQwqJFQggulwRfLiAxuNSfbscjfbJJ7sU+S4Q2F/uXn16kfIejhMCc29+LOJ4LmlKeMSZMFPcW9JF/eqTwkoEe0qUR/MqneId1oREmVI=;5:xBIDnQo1dvZHDNNSUVvSjLzyA2BMu3SeShU73CAVSp9gVMo7zdeDwLZhqcmkFzuTSrl86BA62PtBAmBcZsMVUqXT+IkkR0fRqhfgOBkgfyRu0MfMnDrFsdL3jEWm2AEi97kEMFd4pIuh0VgMNS+fZdQTLw1DcJKedkXX19DOLUw=;24:CIClAgJnJrEAVtdVWKQ5IBRMGqQPCrdLYoVkl8FnruQuDo8WjoFErDRwzBGviErBOSk+qdvX0WmRFvhHpDQvhanBU64qEb++8DvLktQSWaU=;7:7gmD/QsgUVC554kpZgsjiGV9yFTdolWtrPCwAItBNlnXKuy6J3vHAA6p9AX4sIrDXr/F6wlZYFqEwAN6nzFsAoyr7Bn4QL9IZPJKDpWcoDs0e9BJ0Qk2LJEWLM+J73mTO1UFtDKBgmfpMreV+ejcb9DG0IBS4mtoSrJr9o30bYBXa6fx1S9Yhx9XPSXbOSnFJ/mWTy080Y0TjlPRSUOAVw/qowzwFfy50Zir74AasryrY2osSg0fWxS+I8hmtcA7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;20:32ijHP6zqCJxSvO5BsqK3EmRpBvXVWKiuzAFAHv8sDlziWdCNWSM/oiV4muu4PUb/VT75ezjDgbRxfRdrA9RBMVn4942dLYQFgLjm29FBPOLO34kpEQkpxgp79ETdBwc5XXwuS6m8qS9JPM9Sb4oaOcoh98KcEF4nieMnuwk8mQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 17:22:04.0794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2714d44-1ae9-4905-f5eb-08d5883dc76c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2500
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594753480085111239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/10/18 7:34 AM, Luis R. Rodriguez wrote:
> Also,
>
> Alexei you never answered my questions out aliases with the umh modules.
> Long term this important to consider.

aliases always felt like a crutch to me.
I can see an argument when they're used as 'alias pci:* foo'
but the way it's used in networking with ip_set_* and nf-* is
something I prefer not to ever do again.
Definitely no aliases for bpfilter umh.
