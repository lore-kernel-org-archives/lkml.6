Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeDCNoZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:44:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51285 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeDCNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:44:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180403134421epoutp01eb512b4702b43fa84372600d29fee8c4~h8O-Edm2Q0932509325epoutp01g
X-AuditID: b6c32a4a-d07ff70000000fed-9b-5ac385349b98
Message-ID: <576192949.596772.1522763027665.JavaMail.jboss@ep1ml501>
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] lz4: Implement lz4 with dynamic offset length.
Reply-To: v.narang@samsung.com
From: Vaneet Narang <v.narang@samsung.com>
To: Maninder Singh <maninder1.s@samsung.com>
CC: "sergey.senozhatsky.work@gmail.com"
        <sergey.senozhatsky.work@gmail.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180403122642.GA26934@jagdpanzerIV>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Date: Tue, 03 Apr 2018 19:13:47 +0530
X-CMS-MailID: 20180403134347epcms5p7bcb66ea0251dd4637325fc2a6318b165
Content-Type: multipart/mixed;
        boundary="----=_Part_596771_1741584878.1522763027665"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180403134347epcms5p7bcb66ea0251dd4637325fc2a6318b165
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjH995df0BWc1QYj0wdXuYmxNa2acuxWDM3Zi7DP9hmNMMt3Qln
        y6TXptciLJnpH6ArTSmbhWjtxEjUrIgokxaoRiz7oWygYLI4ksFgbnEGx4YygzizlqPZ/vu8
        n+f7vE+eN3nluDIsy5NX8S7OybPVlDSTiA4WFKj0DYPlmuB0Lj0a5+hw11kpfbWngI5d+FtC
        L3b4pXT4Rj1B++6tpr/32ejJiQWMvtUfltKDbQcJ+vT8rIw+Xx+S0RMzPRg93fwZRs/cnCBe
        JZloPCphQh6/lDnmGSWYi1/8iDHNgTnE9IV+kjHRgfVM+6XfMaY74pUy144sEkzTxUiyOPel
        hHnQvbZMUc5ttnJsJefM5/gKe2UVbzFRpe+YXzcbjBqtSltMF1H5PGvjTFTJ9jLVtqrq5FpU
        fg1b7U6qMlYQqE1bNjvtbheXb7ULLhO1W6vVqbWaIrVOp1PrDe+/ojMkIx9w1sh3XZhjaGPt
        SN8t5EHelxtRhhxIPcQGFlEjypQryTiCy4/7UKqgIEugOdqKNSJ5krPgn96VKb2SLIU/Ow9K
        Uqwk18K3t+NI9Bvh2vGzKBWXkoXwV/2uFGYntf8HPHU7TvqkcGFoSiKOVcCRQ78SIj8PsTM9
        S60ZpA6mYnZR58ATTzqSA7PftCGRs6FhYhgXOQt+Xogv+9XwaD4gSc0C0ofgj8NxQjwEEXhm
        0t1FcON621I3Qa6HyTOjyxNKINIxvsQ4uRPGBuYw0a+BlqFzy2yCplGvRMysAP/iHSy9TO/x
        NFMwcrVPKjLAHe9RPLUYkAycuGsU9VbofDKON6N1of8eN/S/wSK/ALH7YTwVwckC6OrfJOqX
        IBh4KBXZCJ5DLYTI6yDom5KdQLIIWsU5BJuFEwwOHc/tVwusTXDzFnWF3daNln5D4Zu96PTI
        9gQi5Yh6VuF4I1GulLA1Qp0tgV5M3jV9vuMmyiN4O89R2YrPPxwsVyoq2bqPOKfd7HRXc0IC
        GZLP9ymel1NhT/4z3mXW6os1eqOxSKvRFOupXMXWt0rKlaSFdXH7OM7BOdN9mDwjz4O2DO/K
        DO/IUr2756R+NqNnw9i42fawZsPldtUnLe2WpvDMx8SY/n5V1mE3tffpMWpbg/16Q+2+K+b3
        VuzGX7P498daTx2Yf7rnEb3qF3X7lf6dxbm/eXdcOpArq71r1Z8q/frtvYXnHpvqWjtsgdbb
        zz3zlezkdBALLNxbM2xJdA5MPqAIwcpqC3GnwP4LedUmSS8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd
X-RootMTR: 20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd
References: <20180403122642.GA26934@jagdpanzerIV>
        <20180321074948.GA2746@jagdpanzerIV>
        <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
        <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
        <20180402055152epcms5p546fdb62381b769ed0c719f3bedcee3b8@epcms5p5>
        <CGME20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd@epcms5p7>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_596771_1741584878.1522763027665
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi Sergey,

>You shrink a 2 bytes offset down to a 1 byte offset, thus you enforce that
2 Byte offset is not shrinked to 1 byte, Its only 1 bit is reserved out of
16 bits of offset. So only 15 Bits can be used to store offset value.

>'page should be less than 32KB', which I'm sure will be confusing. 
lz4_dyn will work on bigger data length(> 32k) but in that case compression
ratio may not be better than LZ4. This is same as LZ4 compressing data more 
than 64K (16Bits). LZ4 can't store offset more than 64K similarly
LZ4 dyn can't store offset more than 32K.

There is a handling in LZ4 code for this and similar handling added for LZ4 Dyn.

Handling in LZ4 Dyn: max_distance is 32K for lz4_dyn and will be 64K for LZ4
int max_distance = dynOffset ? MAX_DISTANCE_DYN : MAX_DISTANCE;

>And you
>rely on lz4_dyn users to do the right thing - namely, to use that 'nice'
>`#if (PAGE_SIZE < (32 * KB))'. 
They don't need to add this code, they just need to choose right compression algorithm 
that fits their requirement. If source length is less than 32K then lz4_dyn 
would give better compression ratio then LZ4. 

Considering ZRAM as a user for LZ4 dyn, we have added this check for PAGE_SIZE which
is source length. This code adds lz4 dyn to preferred list of compression algorithm 
when PAGE size is less than 32K. 

>Apart from that, lz4_dyn supports only data
>in up to page_size chunks. Suppose my system has page_size of less than 32K,
>so I legitimately can enable lz4_dyn, but suppose that I will use it
>somewhere where I don't work with page_size-d chunks. Will I able to just
>do tfm->compress(src, sz) on random buffers? The whole thing looks to be
>quite fragile.
No thats not true, lz4_dyn can work for random buffers and it need not be 
of page size chunks. There is no difference in Lz4 and Lz4 dyn working. 

Only difference is LZ4 dyn doesn't use fixed offset size, this concept already getting 
used in LZO which uses dynamic size of Metadata based on Match Length and Match offset.
It uses different markers for this which defines length of meta data.

lzodefs.h:

#define M1_MAX_OFFSET   0x0400
#define M2_MAX_OFFSET   0x0800
#define M3_MAX_OFFSET   0x4000
#define M4_MAX_OFFSET   0xbfff

#define M1_MIN_LEN      2
#define M1_MAX_LEN      2
#define M2_MIN_LEN      3
#define M2_MAX_LEN      8
#define M3_MIN_LEN      3
#define M3_MAX_LEN      33
#define M4_MIN_LEN      3
#define M4_MAX_LEN      9

#define M1_MARKER       0
#define M2_MARKER       64
#define M3_MARKER       32
#define M4_MARKER       16

Similarly for LZ4 Dyn, we have used 1 bit as a marker to determine offset length.

Thanks & Regards,
Vaneet Narang
------=_Part_596771_1741584878.1522763027665
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIDEvMV0g
bHo0OiBJbXBsZW1lbnQgbHo0IHdpdGggZHluYW1pYyBvZmZzZXQgbGVuZ3RoLg0KICAgICAgRnJv
bSAgICAgICA6IG51bGwNCiAgICAgIFNlbnQgRGF0ZSAgOiAyMDE4LTA0LTAzIDE3OjU2ICBHTVQr
NTozMA0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQogICAgICAgICAgICAgICAgICBOYW1lICAgICAgICAg
ICAgICAgIFR5cGUgICAgICAgICAgSm9iIFRpdGxlICAgICAgICAgICAgICAgICAgICAgICBEZXB0
LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDb21wYW55ICAgICAgICAgICAgICAgIA0K
ICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQogICAgICBNYW5pbmRlciBTaW5naCAgICAgICAgICAgICAgICAg
VE8gICAgICAgICBFbmdpbmVlciAgICAgICAgICAgICAgICAgICBTUkktRGVsaGktUGxhdGZvcm0g
Uy9XIDEgVGVhbSAgICAgICAgICAgICBTYW1zdW5nwqBFbGVjdHJvbmljc8KgDQogICAgICBzZXJn
ZXkuc2Vub3poYXRza3kud29ya0BnLi4uICAgQ0MNCiAgICAgIGhlcmJlcnRAZ29uZG9yLmFwYW5h
Lm9yZy5hdSAgICBDQw0KICAgICAgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldCAgICAgICAgICAgIENDDQog
ICAgICBtaW5jaGFuQGtlcm5lbC5vcmcgICAgICAgICAgICAgQ0MNCiAgICAgIG5ndXB0YUB2Zmxh
cmUub3JnICAgICAgICAgICAgICBDQw0KICAgICAga2Vlc2Nvb2tAY2hyb21pdW0ub3JnICAgICAg
ICAgIENDDQogICAgICBhbnRvbkBlbm9tc2cub3JnICAgICAgICAgICAgICAgQ0MNCiAgICAgIGNj
cm9zc0BhbmRyb2lkLmNvbSAgICAgICAgICAgICBDQw0KICAgICAgdG9ueS5sdWNrQGludGVsLmNv
bSAgICAgICAgICAgIENDDQogICAgICBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnICAgICAgQ0MN
CiAgICAgIGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbSAgICAgICBDQw0KICAgICAgbGludXgtY3J5
cHRvQHZnZXIua2VybmVsLm9yZyAgIENDDQogICAgICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnICAgQ0MNCiAgICAgIFBBTktBSiBNSVNIUkEgICAgICAgICAgICAgICAgICBDQyAgICAgICAg
IFByaW5jaXBhbCBQcm9mZXNzaW9uYWwgICAgIFNSSS1EZWxoaS1QbGF0Zm9ybSBTL1cgMSBUZWFt
ICAgICAgICAgICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNzDQogICAgICBBTUlUIFNBSFJBV0FUICAg
ICAgICAgICAgICAgICAgQ0MgICAgICAgICBTdGFmZiBFbmdpbmVlciAgICAgICAgICAgICBTUkkt
RGVsaGktUGxhdGZvcm0gUy9XIDEgVGVhbSAgICAgICAgICAgICBTYW1zdW5nwqBFbGVjdHJvbmlj
cw0KICAgICAgVmFuZWV0IE5hcmFuZyAgICAgICAgICAgICAgICAgIENDICAgICAgICAgU3RhZmYg
RW5naW5lZXIgICAgICAgICAgICAgU1JJLURlbGhpLVBsYXRmb3JtIFMvVyAxIFRlYW0gICAgICAg
ICAgICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

------=_Part_596771_1741584878.1522763027665--
