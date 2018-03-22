Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646944-1521693484-2-9268558286884939191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521693483; b=mYiMpIrk4wOg85c07b5i4ka43p5HTrV0/ENJ7hbrXXhLPi4
    LRDNyRhdP29j2qexGyKN5T+ZGn+eJgc5+HQSikfsf7OanX/FRhOX96Zq+t2PUIJw
    drJm8Gy5YFknpL0ikB1JN7OIsePsedO/pERvaDNKQlS+iNFHbm1tStT732uHhgfI
    6WVn+451TuyCpHENv5Z/zJ955AzCXG/WnoZqt0rXjLUbZPQNltcuQzk7ijfIR5AA
    FQCjTvQabe86uzBV1A3IojO+usRIZl2d1tPI0T+pM8BkvypWJcg9bonkYLQUlVI+
    dmPdn2lLzjNzvIjdwyr4mQ2cip0bwx0sTrFE4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1521693483; bh=OnbxCZYd
    AXFED08rcoDumGImxcVwrB+mBjKg4zGwgAQ=; b=CpMsiLtKp81AeKNrMfjdxjD8
    yJ8UeD3KXniReuit6s3cHjchKT1RVR5lsLVnvKmfcelXXjH8zteVgVBg8jBH1ily
    82kmT3NHNpAN953nxITT++modjc8UVH9fHteK77xxeXjNIh3k0xEKZg8TaeoVPCF
    t2BjPZP67xXTtgE8+lKMIDfuPkjHWOviNITEIdRVvop1vzIr/1hTPoGYA/gtdJwv
    BZhZ8Fw8OULjMWz5hPimJ3wFev3s2CK+LN3YQ1t1dJZ6Xlrim3yp65ia2jvNLu5i
    rEpwiSArBLvQ3DDVTx2gCCCmOAlliKxeyhk7bkbnS7mQiLNGpEmo6sviXosHnA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=L909Iu7A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=L909Iu7A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCVEh6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 00:37:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45365 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeCVEhz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Mar 2018 00:37:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180322043753epoutp0118492ff274d9dff44f12617dd04463a7~eJCbWyDEg2584925849epoutp017
X-AuditID: b6c32a39-467ff70000000fc5-47-5ab333218fbf
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: "y.k.oh" <y.k.oh@samsung.com>
Message-id: <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
Date: Thu, 22 Mar 2018 13:37:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180314135804.GA21350@kroah.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmga6i8eYog+kX2S2aF69ns5iy4QOT
        xdZb0haXd81hszizuJfdgdVj/9w17B7rt1xl8fi8SS6AOSrVJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVina0NBIz9DAXM/IyEjPxDzWysgUqCQhNePi/ZWsBZu5KxbevcLSwLiVs4uRk0NCwETi
        49M2pi5GLg4hgR2MEtf/fmCDcL4zSrxZe4gVpmrar/ssEIndjBK9t2cwQjj3GSUe/p3PCFIl
        LJAicXDeTzBbREBD4uXRWywgNrNAkcSki2/B4mwCyhLve+czg9i8AnYSFz9fAouzCKhKrH50
        kB3EFhWIkFg49SkjRI2gxI/J98DmcAroS9xt2sAGMVNT4sWXSVDzxSWaW29C2fISm9e8ZQY5
        TkJgA5tE++ctbBAvuEjcOPMA6h1hiVfHtwAt4wCypSUuHbWFCDczSqzZXQ/R28Eo8fHuZ6he
        Y4nengvMEAv4JN597WGF6OWV6GgTgijxkPjZupAJwnaUOLplNjS0djFKPLrbyz6BUW4Wkn9m
        IflhFpIfZiH5YQEjyypGsdSC4tz01GLDAlO94sTc4tK8dL3k/NxNjOAUp2W5g/HYOZ9DjAIc
        jEo8vBk5m6KEWBPLiitzDzFKcDArifAe0twcJcSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPz
        gek3ryTe0MTSwMTMyNTU0MDCREmcNyDAJUpIID2xJDU7NbUgtQimj4mDU6qBccuu9yt37p0l
        sr1yv3WuSOGEcFs2AfewXJZQboPnz1mjL+2ZyrfuzeT31otWyH+8sJJTfMIKExNXtcpJPYH3
        XO+vaNcQrkyTY5h90It13+xaU+G+h+KSwv5Gi45Jbb4382p9c/rj43nvlR9PWPQlZ9K8SRKr
        hVZefcRtvOxCi71g2laLTVfWvlZiKc5INNRiLipOBAD7HHnDhwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t9jAV0F481RBt1PTSyaF69ns5iy4QOT
        xdZb0haXd81hszizuJfdgdVj/9w17B7rt1xl8fi8SS6AOYrLJiU1J7MstUjfLoEr4+L9lawF
        m7krFt69wtLAuJWzi5GTQ0LARGLar/ssXYxcHEICOxkl5j78zgrhPGSU2L+lmQWkSlggReLg
        vJ+MILaIgIbEy6O3wOLMAkUSzYv/s0E07GGUeLr6AFgRm4CyxPve+cwgNq+AncTFz5fA4iwC
        qhKrHx1kB7FFBSIkOlfOZ4GoEZT4MfkemM0poC9xt2kD0FAOoAXqElOm5ELsEpdobr0JtVde
        YvOat8wTGAVmIemehdAxC0nHLCQdCxhZVjFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525i
        BIb2tsNafTsY7y+JP8QowMGoxMObkbMpSog1say4MvcQowQHs5II7yHNzVFCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1MLqbeJ/esE49IV5+qvcVyRl3
        f3kaPm0+1trJ7KF0LdnkYe03zjXOFqJPDk8rfx+0uVOpo/XTgicPuk8zby64OPGZbuV+vv6I
        q5e9hVW35k/Ktt3Z12qps+TU+y88x9+enLLav3XVnrVpZ3vzFzt5han3eDRdm6B7Lyu8/vKT
        Kfs/HYuoumpy/IsSS3FGoqEWc1FxIgB4C2TZaQIAAA==
X-CMS-MailID: 20180322043752epcas1p19df1762006aedbc77aaa354285dbf2d7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
X-RootMTR: 20180314021710epcas1p3766602fe312f87d916cab69af2acf203
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
        <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
        <20180314135804.GA21350@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/14/2018 10:58 PM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
>> Cleanup checkpatch error:
>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 3f2f8c1..da9bddb1 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
>>  }
>>  console_initcall(s3c24xx_serial_console_init);
>>
>> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
>> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
> 
> That's not a complex macro!
> 
> Please use checkpatch as a hint, not the "truth".
> 
> thanks,
> 
> greg k-h
> 
Dear Greg.

Yes! Of course that's not a pretty complex macro. However, I think it is
important to make a small effort to modify the minimum standard,
Checkpatch ERROR, to ensure consistency in the Linux code.
Starting with this Checkpatch error of samsung.c, I would like to start
my efforts on contribution from a small point.  Please review it again.
If there are any points that require modification, such as comment,
then I'll modify it.
Thank you.

Best regards,
Youngkeun Oh
