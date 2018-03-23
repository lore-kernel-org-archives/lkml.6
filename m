Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeCWNj0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:39:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31342 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCWNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:39:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180323133922epoutp0244d87ff84e0b8e269194a82f8918f4e4~ekEfQijc22898428984epoutp02l
X-AuditID: b6c32a4b-cd1ff70000001126-75-5ab5038908d4
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] lz4: Implement lz4 with dynamic offset length.
Reply-To: v.narang@samsung.com
From: Vaneet Narang <v.narang@samsung.com>
To: Maninder Singh <maninder1.s@samsung.com>, Yann Collet <cyan@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>, PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180322042821epcms5p16b4dd6fc12a1563b5aea547f398dda40@epcms5p1>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180323132119epcms5p8699c2b53a3bab062013e2b3238d0088c@epcms5p8>
Date: Fri, 23 Mar 2018 18:51:19 +0530
X-CMS-MailID: 20180323132119epcms5p8699c2b53a3bab062013e2b3238d0088c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180323132119epcms5p8699c2b53a3bab062013e2b3238d0088c
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXeO8ygtTsvRk5WOA0VKzp21uTNtUmS10sLoQ7GKddKXKbmz
        sTO7fYhVdnFhM7MoCRcVlhUVlmkOGSloV2+F1ActutBdkQqTLrTtNOzb73n4/9//8z48FKH0
        y5OpUsGD3QJfxsgTydudaWkZlUSzVXshpOX6g5hr3reVezE8IeOetJ2Rc52BgyQ3/LlZxr2q
        rpFxH/8MyhdTlmP7R+Itd+qG4i1Hb11Glq9NKYWkFS8qwXwxdquxUOQsLhXsZiZ/nW2pzZCl
        ZTNYE2dk1ALvwGYmr6AwY3lpWXgIRr2dLysPtwp5UWQycxe5neUerC5xih4zs5FldRpWa9To
        dDqN3rA5W2cIS7bgkvYaH+Hyzdv54G4l6UWPZvpQAgW0HnoPDyEfSqSUdBDB4N5OwocoSkFP
        g9+t0yOa6fQKCBx/iiKspFOg+1kQSf0FcK/+KorI5XQ6jFWsjzyTRO9F0HivPS5SEPQ3BP7e
        wTgpTAGnDr0lJZ4FLRebo+YEeg1catgitVXwyxuTqGC0K4AkToIDw48JiafBy4ngv/5sGP/u
        j2YBfQTByPEgKRW1CLyfY24j9N4PRN0KejV8f9UWHwkm6bng7zFKkjwYfjggjzBBp0LLlzPR
        PRB0Glxvy5Qkc+DEg2syic0w0PeOlORToernG1nsi631MWag5+4ducQAbypP/5vfAj1HH6Nq
        xNRNbrruv+C6yeCziLiMZmKX6LBj0eBaKOAdGpF3iOWCXVPkdDSh6DGm57eipp6CDkRTiJmi
        ONVx06qM47eLuxwdCCiCSVJwH25ZlYpiftdu7Hba3OVlWOxAhvAGjhHJqiJn+LQFj43Vm7T6
        rCwjq9Wa9MwMxZK1eVYlbec9eBvGLuyO+WRUQrIX7cnpbuvKqK5o2d9+43WfrNRwMXF2FTvf
        rN2gsFtHD28a9/b94EJVKsHSOOtayHXl3GiNriGUc7ORPzGuMvVPjLw7n+sM1daMnRwNnFuB
        djthLGGlf1X+0HNfJv+p1qRO/VYQn92Z41u9xuY4nadhlrHmtw0uWX2u9dKv99kEQ4olPJtO
        uEX+L/wpEc6iAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0
X-RootMTR: 20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0
References: <20180322042821epcms5p16b4dd6fc12a1563b5aea547f398dda40@epcms5p1>
        <20180321195906.1260480-1-terrelln@fb.com>
        <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
        <CGME20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,

Thanks for your comments, Please check my reply to few of your comments.
I will be sharing benchmarking figures separately. 

> 
>> +                        if (curr_offset > 127) {
>> +                                curr_offset = (curr_offset << 1) | DYN_BIT;
>> +                                LZ4_writeLE16(op, (U16)curr_offset);
>> +                                op += 2;
>> +                        } else {
>> +                                curr_offset = curr_offset << 1;
>> +                                *op = (BYTE)curr_offset;
>> +                                op++;
>> +                        }
> 
>The standard way to do variable sized integers is to use the high-bit as
>the control bit, not the low-bit. Do you have benchmarks to show that using
>the low-bit is faster than using the high-bit? If so, lets comment in the
>code, if not lets use the high-bit.
> 
We are not sure about performance difference of using low or high bit but Since as per 
LZ4 specification, offset needs to be stored in little endian format so keeping Low bit 
as control bit makes it easier to retreive offset when offset is spread across two bytes.

offset = LZ4_readLE16(ip);
if (offset & 0x1) {
	offset = offset >> 1; // Just one Right shift
	ip += 2;
} else {
	offset = (offset & 0xff) >> 1; // Only Two Operation for one byte offset
	ip += 1;
}

So not sure if keeping High bit will make much difference as we will be needing 
same or more operations to get offset in case of High bit.

>>                  /* copy literals */
>>                  cpy = op + length;
>>                  if (((endOnInput) && ((cpy > (partialDecoding ? oexit : oend - MFLIMIT))
>> -                        || (ip + length > iend - (2 + 1 + LASTLITERALS))))
>> -                        || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
>> +                        || (ip + length > iend - (2 + LASTLITERALS))))
>> +                        || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH - 1))) {
>>                          if (partialDecoding) {
>>                                  if (cpy > oend) {
>>                                          /*
>> @@ -188,13 +190,31 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>                          break;
>>                  }
>>
>> -                LZ4_wildCopy(op, ip, cpy);
>> +                if (dynOffset && length < 4)
>> +                        LZ4_copy4(op, ip);
>> +                else
>> +                        LZ4_wildCopy(op, ip, cpy);
>> +
> 
>The LZ4 format enforces that the last 5 bytes are literals so that
>LZ4_wildCopy() can be used here. I suspect that having this extra branch
>here for `dynOffset` mode hurts decompression speed.
> 
This check is made to handle one byte read overflow when decompressing last frame. wildCopy does 8 byte copy blindly.

Issue Case:
0 length literal followed by 1 byte offset and then it ends with one byte token and 5 Byte Last Literals.

With this combination only 7 bytes (1 Byte Offset + 1 Byte Token + 5 Byte Literal) remains at the end of 
input buffer so reading 8 bytes from input buffer results in 1 byte overflow.

Since 1 byte offset is not there in original LZ4, so this issue is not possible. To avoid overhead of this check, 
we planned to use 6 Byte as Last literal Length.

-#define LASTLITERALS    5
+#define LASTLITERALS    6

>>
>>  int LZ4_decompress_safe(const char *source, char *dest,
>> -        int compressedSize, int maxDecompressedSize)
>> +        int compressedSize, int maxDecompressedSize, bool dynOffset)
>>  {
>>          return LZ4_decompress_generic(source, dest, compressedSize,
>>                  maxDecompressedSize, endOnInputSize, full, 0,
>> -                noDict, (BYTE *)dest, NULL, 0);
>> +                noDict, (BYTE *)dest, NULL, 0, dynOffset);
> 
>You'll need to use the same trick that LZ4_compress_fast() uses, by hard
>coding `dynOffset`. We want the compiler to generate too version of
>LZ4_decompress_generic(), one with `dynOffset` and one with `!dynOffset`.
>That way the tight loop won't the branches that check `dynOffset`.
> 
>        if (dynOffset)
>                return LZ4_decompress_generic(..., true);
>        else
>                return LZ4_decompress_generic(..., false);
> 
>Without this trick, I expect that this patch causes a regression to both
>LZ4 and LZ4_DYN decompression speed.

Since there is no backward compatibility of our solution with original LZ4 so we
are bit confused if we should make it as separate API to avoid overhead of dynOffset
checks every where in the code and also to avoid changing prototype of exported functions 
LZ4_decompress/LZ4_compress OR we should keep these checks to avoid redundant code. 
Kindly suggest

Thanks & Regards,
Vaneet Narang
