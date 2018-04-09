Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1467502-1523290940-5-4135501578584953286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1255'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523290939; b=XnAJA93HBd+MUNAZdOorBcMWGcof2Syzkr1H7iWOGmwHzrmaAn
    lxanY7mFnuXOYbU2MUWLaJaYQdyQ6NJlTIGccpL76X0RwO3a/84hBHdbLhv5eCuW
    owwKbJ3y27MjCXo2tcaRLCmIIRNxaXXRbn4BPQUvBVPF1sA2Un5SeHGGSOs0oCds
    kO0jn+NP5qMug0ok5J7ir3X4ME0e2wOwVn045ZjG8MXDkn9IzDflu9cV/1QlqIYk
    HwaQ0/v8I7z0ra4D4MBQg4FlrJJyQKqsIkjjLo9NA1+wRZWPhtk+8E0cm+I+eZOX
    uyp2730kZS74pMsmdcNIZ+mzqjiK+YGyfWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523290939;
    bh=uISCFJgY51g2n0+vM8EceeqYcxHncNxtTzTc38lNsRw=; b=lVeTj5JllXT5
    ZD3v1DFp/jFILWhCo1DGJg5QAHxFPddRz25x+IIXcnInsvAV6Zjr1oJE58Cir+K/
    zotycBuzWKlU2/wEmeW/nlBDxjUyZsoQEdq5UkovKOeGwPr/E+BzKtTKrsasYnbE
    oPJZLshFnGomdGEe4eZ4eKSujFBVT55iuf0Woxr1CUYcc+jR4dWRBPQhf2JwLZZr
    mksetfz6unz2q5FPFREGPwH2tWS0hQsiSLzkgA3jPsMobi6gaDc7nesEsyPI/ePC
    5ZXPgpxKVj1F+1nlTbGwNMQRoMxjEgLdI3eCV8Ou5uD4cTU8G241mYeZDWpdJi40
    1z5/oCbqmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=CPg5wQEh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=CPg5wQEh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJg/jb6VUc7J5cQWQRk6BIo/rdOz0RKSDjxposMswvTcYwo25K91STh7MboOzX9BORzugnqHYwOQHakE219W/SmIKLP6rLmTqV7jh9/WWL/7XwhNSLKW
    PygFeD1jhE4QSU86PydDZMM2o6SFXqLlrj1dhsH4EyJxH/ia9/dr+c8pxsAJN1nvNaaFv5RTDkGa5BV6AAOUBuQNFn9sIHbeauMvA8VOWQ+3N1h6ghEJcrDG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IIdj81ZF-LoA:10 a=eiiG2-KLA_wA:10
    a=lNGk4Rm3YwcA:10 a=Kd1tUaAdevIA:10 a=CbDCq_QkAAAA:8 a=JF9118EUAAAA:8
    a=dqWlGzSaAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=6ZtFhi6Yg4p9wuD0YGYA:9
    a=__FU7qRyqSzQ0LYn:21 a=6B1-r_H7pGSooPtz:21 a=F99EeyZzka0A:10
    a=1qrBK16LubpBFNPVNq2M:22 a=xVlTc564ipvMDusKsbsT:22 a=zQxbTC3D8LPejNAg5Fck:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeDIQWQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 12:22:16 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:12672
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753150AbeDIQWO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 12:22:14 -0400
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Subject: Re: [PATCH AUTOSEL for 4.14 039/161] IB/cq: Don't force
 IB_POLL_DIRECT poll context for ib_process_cq_direct
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Doug Ledford <dledford@redhat.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-39-alexander.levin@microsoft.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <49117250-bfbf-53c2-8178-5359a08ef3de@mellanox.com>
Date: Mon, 9 Apr 2018 19:21:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409001936.162706-39-alexander.levin@microsoft.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(316002)(16576012)(31686004)(2501003)(356003)(64126003)(26005)(65826007)(77096007)(6116002)(2906002)(58126008)(6246003)(81166006)(5660300001)(106002)(476003)(81156014)(54906003)(2201001)(59450400001)(106466001)(229853002)(486006)(110136005)(126002)(8676002)(8666007)(7736002)(65806001)(65956001)(36756003)(305945005)(6666003)(8936002)(47776003)(4326008)(45080400002)(446003)(67846002)(1511001)(50466002)(336012)(3846002)(478600001)(230700001)(31696002)(2616005)(53546011)(16526019)(11346002)(186003)(86362001)(76176011)(3940600001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR05MB1718;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT017;1:pYKLvoseOkPVHWIY9lQfLGMipkI8iqroHOqUTHXISelWIeavzxr4CIxaP9ZDIYy8N5npQHkPVP1ks5+GWW++sbXuyIneBge7zN4ePWgfXlDHJR9Zlif4yJX/noFJEZ8X
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff13d230-3283-4e9a-915e-08d59e360b3a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR05MB1718;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR05MB1718;3:MaaOWMwsYKTmn2uTaFhG3AXxufPDBrKtPQvr70Q/PsifkMIHdi2rnIhzJvxX3+Y5zuDD4aXsype4LDgmjHHhh7fLdKeWc1WSF0DAhttAzRy+wIaeIlO476AegYT+ARVDSY8E7aiq4BEdKxB1o+RZlz3slKjIvzfYVQ5e40gA25pD1l2S4hUhxU4HTpQvUJB3tbofY0ZnFbv7U7W77cCIqaUIai3QzCcsAH0SjTyTegGUr2VYA+waatz/Damm6HdCGj4QW4kzH2pldqcB4OITWo1bB0+aZWy+ERWZqtdZp/7XRJPHXZMfgGD33eMqhBGT4BOpN/UXlzg64kESLtnsnXJMnKT/p7EvGiocm74RtL8=;25:1WaTp2eskIdPjqYP/doSV12RWHNHeNOcpni4iRbCiNC4C85MBWKRIrX+d4f5yhX9YqMb61jv7lpU4bYZSeLKIpq65+RCfq0gN1G/uQv+UGLN6oyqWLX7baIU/2zbFzcg/yDJOj0YMPdo0pXFYKMiSWxU3dhbHetJuoD8CB2xog296weUCG7ST06l87fvx6eDfQhgPD66snEAi+GH17K8w7UZdknK0rLUtvJCLMEzW/OFWDj2oktMeYGr83Kuw/4heiaZe//02JYXE+Jjcq4e4VJtzbhRoDlAITbLv+oMJ+gCqshh+8Sd6sYE/EhcFByImwgRpRwdahftpuA5eYkTcg==
X-MS-TrafficTypeDiagnostic: DB5PR05MB1718:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR05MB1718;31:svLhdCUmdRNXIs+x5mHnfyP+pWOM6e+X1kts9yTR07DaeWQFpBx8lNKwcLIQ9jInUgIDnz+/Sk5lOSQl+/9miqgmTcj1JNXJEu2SGeDS64ayLzL1Er9lx1yWuOKO4hX0ZALQezgnx1aiRVYsEjUcxah0dXn0CeqYEJvbOTQmKxpWb+ZBX/0F4dseOKweXKL49Pv1rH3Jzh5Y+LCqUvfX9MbMfY2RZ3IQJJxbmBb8g58=;20:AU09BHNyd4kZmgS/g/HsTtbESv7+ZrQLRya1IMg817ww4iYZn6tNcc70EGg0qVB7+CsCse7VyDAMPHsJktNzzlcAakF2AvWw1vFkmlNnLL/6VGkFwW3g2VqQcRcLIYl9cthCFDFSXBR46eQ6EwFzmgmiMm1EErrG2Um0EJZLQsJf1n93zAJOGy5H9NT/KcmXF2FxhXwDJbsCqSkFQp4yt6/DNeRELB8MmJ+uFPAqTPep/r528lsYsr6qMNvl6FWSEIKGOEp+2d18eMVJrFfFWaSup2ZkkExHeoJZpVIEJuKWy9GqyBzNTYYclI2XJQaP8h5am4dlD+w21B7WPOMZy2tMMFfTfzFuM66b+IxqaxWPFB2qOH4ojf5F9G3QKGXIHpK2/Iz1sXRc8L8rbVZdsTzGJ8eCF83LJBwC87L5Uxn6pt11vyeUCcvmMFxNjyndwiMdG8NAyI02xALiPvR61I4A4J3T03qWz/w+Gaiq9iZ/pY0CTqS0181BOEex6Ees
X-Microsoft-Antispam-PRVS: <DB5PR05MB1718B9EB4C95F178073FB303B6BF0@DB5PR05MB1718.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB5PR05MB1718;BCL:0;PCL:0;RULEID:;SRVR:DB5PR05MB1718;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR05MB1718;4:vHBNKPJv/LWuGARHWSInPSoPm9qfzZ/HJWvyFPM4mB+68Qd311Ref7oARbP/ANSrn0zVkuXJUObOpqhmQUvc32helOeSy61yDEQcJiirDnzppWR/0K5iEJs03+wy9D4ZavP6hDUqo+Oeore+5zmLUZ6rAlps92dkJUyCjtrb6x+DFOsfeIhzerY/5hFiSmtLcvuPUjlLud50PN6CF6vNexwawuVplhdQQCsJHFICxC9hKs273qsD7Q13HzV6xtFACxYlCFout/kBsCgNr2Gsy10S9/fEE9kqhVO/6D0SWe8+KvPlk7IrKwCaDd6FJ6ZCZp+Mhl+xnzeJabNucuY96c4K8Np3XM2mmfNAuf9MCL8=
X-Forefront-PRVS: 0637FCE711
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;DB5PR05MB1718;23:HLXZbANlTWtoDn7f8esyHTs58PvzkJW8hBehS?=
 =?windows-1255?Q?lSVcSiXbiDvoRrOB2kkrAhsdjHVJ4OKDcp4w8rfXBTdDQS37ozezb/HO?=
 =?windows-1255?Q?m8sm/7rXCybS7eGpXcUz0NhWq9QKfIir0OQ66wq2Y/FfxkM3srRIFHuJ?=
 =?windows-1255?Q?Yd/+gyBmO1nS/1owMxv+11CSRFWi4UN2/i2ZkCZyUZWsQy4uVUozUKPO?=
 =?windows-1255?Q?lSSZ3EDgaxRVcIK+LGRNb/rE3crBrJATBtF2uaBvQE7iq2/6zDJEdsb6?=
 =?windows-1255?Q?837CIETfwankLf9pr5NSEdU5Y1r70WFu8W3ABKkAWrBiRmbnKI3jxUHl?=
 =?windows-1255?Q?Cxe9JqLaz1O3ry3zEOxczfyAJlJdZKXeWkfGH1k5KzV/qK1hDG9eBZ95?=
 =?windows-1255?Q?L+AMhahSV+dZvKGgwcKzoW4gJf23EVCnvZiOCMEUGmu1g2O7OXxDfw5b?=
 =?windows-1255?Q?vLQCOBAr3ZQkxRTwJiB0gJ7CnusoCiOPVVEYDzrwoutuRXtcjzJcA7fy?=
 =?windows-1255?Q?lH1bk/KKAAH0AuwQtaT/Wc9MSwL9iGSBxlNl8LAJ6z3g9Il8ZsRsis+8?=
 =?windows-1255?Q?6zcaS/mZMzvvP6sIcg1CpwKBeo6p3ZBg3/dQaqo6UUqYgQS58Y6x5TTJ?=
 =?windows-1255?Q?FP2N1KGON8LLFtW2ASnC/D22DXqMO5CAq28jMHax/zC9MXmT3F7fmKsL?=
 =?windows-1255?Q?3S51DST8+jRCpSG9PrjKb7Oa+SQAcQnnBh467hkARwtVLnMLqKu2srIr?=
 =?windows-1255?Q?pPV3dwxEJKQ0kR6XeO5hDvWxLJVAZ6+Jt1u4TR+Pc+xK2CXURLv7mWsX?=
 =?windows-1255?Q?FMSdX6YCxXAWH0fJYawp4cf5UpLfRVTn2IxDciQUB6pL6mJu8w3BTDFn?=
 =?windows-1255?Q?3WoNBG2zbp0neCrYN0SR4OWqZc6Bw3CJEbj2yjti33WTESj2m2ijkTj4?=
 =?windows-1255?Q?Vnb1KJWQ3xdN+zni2q6wMjk7Ozd5OXbreyhcSgUUpjB2UQf1uXXTeWz3?=
 =?windows-1255?Q?IyuSQmUS4mlXfGrudTK1HxG8/4QA1cfAtuJgLAwAleg51/8JRp4bn0Du?=
 =?windows-1255?Q?JtVdkBlat4K5ZZ8U9OG3+pAqJPDbVsK9NxV75iPLRaISL836XoRLwdbs?=
 =?windows-1255?Q?VynIKfkCfOrO3SEem0bWMeYoHFrUi6FvJMK3TTxIEmjDClmz89M+GvSk?=
 =?windows-1255?Q?zD6EXO5Mcu6fRAmpLEkEcOSBKjiBVYze0FgE+BilctW6EZ7WxEPzXVWz?=
 =?windows-1255?Q?y+wUlima2Wd9thh6hbyRL0iMH3f+P8GxfAUzK7s/znUcS6rbP8cGOGLN?=
 =?windows-1255?Q?z8KqC060oGeBoQvctw+NK29ocsy/5kn05FpP+rZjWc7YdIMskxaVeRkV?=
 =?windows-1255?Q?n5pqjwpoXy14hm0k8mhOXjRGaEFX+2DDQtbsbJlybDej4nb4zr3bJ5jA?=
 =?windows-1255?Q?+ehFiloYjEGBk5mzclFlHuy/MDiEoIdmQlImesoPW61kg7A8gzby6goQ?=
 =?windows-1255?Q?5oZs7GLc3i1BDs88pRMISIhfcvPoEYRPvSkVpBQBaPoSO7/79xheeLiB?=
 =?windows-1255?Q?Fih/ojC+Ub6xjE=3D?=
X-Microsoft-Antispam-Message-Info: vLceClhDNTvJ8DFpfbiiUkgyb4rp5+JgfHMzimF8FaE0ReCMu8NNiGFjw95VTWSMbUn3M14xPnzMWrJxg6z9r0LF2JM4y7ZRwnApM/7+QER6OnL58x4/3fVXo0vIkwpx/8XmEfcYH3PcE1rhlBuxoNAhF5PA+09XDtNifw1BBMPtXUl3dSdTx478M0UmqHHB
X-Microsoft-Exchange-Diagnostics: 1;DB5PR05MB1718;6:s4hR5TUsnhwDCkgUff71lqEz/higIYLeYOOIvif53nPniknS84kV6vnY8UefK5qfBNp4WL0V0Gc9rRB785bpDQ0mDL5gGMexB3tEszpd6mUbTxCopVjlNoS90I54BIDx+Mez0k6qENK47UnT8pjSi6UxW+GGt0GScQr4o03K1zYj0av0crfFI/Ra/WLxuO6QSy62eMSp1PKL60LcgF1O43cU1YHSe46mOkIQtlc9NEXDqJigwa6oolM6TJbx1BBkDJsiTzk0WuT4ZE59Zo6jpSNoZRxbdQD1qGMdySw6lzqU4kmEilDAkylXbE2Qi4asa2Z82cS3MbN2+A8vXvIjlIrhpagYCEdNKUnDBd+xxVnFmkRRrYrEYwHfGZhw4v1v2kyiP3odymR8lBDdYoUUI3Juew1H5qwyntfKz/yG3x4l9uFN97C6LA/uHfCEW1jAIKbVpjoo0WU7UQQldVo+tw==;5:raAL0eV9xGKZdlm9swmUXbwOn7xq6XyQsrdX5HrSe+NfO9gJwcgCzGa36eWRV2EHxTfWwkmQq+AbSZzkmNq/KBIUmfkoSJa5r3egbp7rRPU1wAx4LJI9IIMbjB20bt8huAC6AMpt+3YCDndro2+W1Fgo2RJGeaxcWwHRG5Vv/Us=;24:hxNk26PqoNLVHDDtPUR8M4YtjN/bkmTvptTmG0/WLCJxNbo2ZsW6ZZRFi5ORXlH4+/d+WLBhh/931Vj8Xpx30wG3pHHyZh9/rDLH0bm+Abo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR05MB1718;7:9+zBluSy4UMi3bgl704OVxpAZ//ZXES8ClLGBfdO4ufDGL00Zz98IJs7KrA20DOdXFm6pYtW9jABZQzMKZhck33frd4nKg2R+H0oGgqRXh2g/2+OTPNQRIokLNRli09RsHlqA7UWqVkw9rF2pLQL4tET/qqNQy1PsKmCSmYuCoZlmBnJz4P6piiiVv6T0nXwL7k4pLuSZLXqrPg6Sek37Yn1PwRJTdmqo14sBa64c9KSYF/Z1MzYLiY+tgnutvDx
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 16:22:09.4103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff13d230-3283-4e9a-915e-08d59e360b3a
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR05MB1718
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,
please consider taking a small fix for this one (also useful for 4.15):

commit d3b9e8ad425cfd5b9116732e057f1b48e4d3bcb8
Author: Max Gurtovoy <maxg@mellanox.com>
Date:   Mon Mar 5 20:09:48 2018 +0200

     RDMA/core: Reduce poll batch for direct cq polling

     Fix warning limit for kernel stack consumption:

     drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
     drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes
     is larger than 1024 bytes [-Werror=frame-larger-than=]

     Using smaller ib_wc array on the stack brings us comfortably below that
     limit again.

     Fixes: 246d8b184c10 ("IB/cq: Don't force IB_POLL_DIRECT poll 
context for ib_process_cq_direct")
     Reported-by: Arnd Bergmann <arnd@arndb.de>
     Reviewed-by: Sergey Gorenko <sergeygo@mellanox.com>
     Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
     Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
     Acked-by: Arnd Bergmann <arnd@arndb.de>
     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>


-Max.


On 4/9/2018 3:20 AM, Sasha Levin wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
> 
> [ Upstream commit 246d8b184c100e8eb6b4e8c88f232c2ed2a4e672 ]
> 
> polling the completion queue directly does not interfere
> with the existing polling logic, hence drop the requirement.
> Be aware that running ib_process_cq_direct with non IB_POLL_DIRECT
> CQ may trigger concurrent CQ processing.
> 
> This can be used for polling mode ULPs.
> 
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Reported-by: Steve Wise <swise@opengridcomputing.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> [maxg: added wcs array argument to __ib_process_cq]
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>   drivers/infiniband/core/cq.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index f2ae75fa3128..c8c5a5a7f433 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -25,9 +25,10 @@
>   #define IB_POLL_FLAGS \
>   	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
>   
> -static int __ib_process_cq(struct ib_cq *cq, int budget)
> +static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *poll_wc)
>   {
>   	int i, n, completed = 0;
> +	struct ib_wc *wcs = poll_wc ? : cq->wc;
>   
>   	/*
>   	 * budget might be (-1) if the caller does not
> @@ -35,9 +36,9 @@ static int __ib_process_cq(struct ib_cq *cq, int budget)
>   	 * minimum here.
>   	 */
>   	while ((n = ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
> -			budget - completed), cq->wc)) > 0) {
> +			budget - completed), wcs)) > 0) {
>   		for (i = 0; i < n; i++) {
> -			struct ib_wc *wc = &cq->wc[i];
> +			struct ib_wc *wc = &wcs[i];
>   
>   			if (wc->wr_cqe)
>   				wc->wr_cqe->done(cq, wc);
> @@ -60,18 +61,20 @@ static int __ib_process_cq(struct ib_cq *cq, int budget)
>    * @cq:		CQ to process
>    * @budget:	number of CQEs to poll for
>    *
> - * This function is used to process all outstanding CQ entries on a
> - * %IB_POLL_DIRECT CQ.  It does not offload CQ processing to a different
> - * context and does not ask for completion interrupts from the HCA.
> + * This function is used to process all outstanding CQ entries.
> + * It does not offload CQ processing to a different context and does
> + * not ask for completion interrupts from the HCA.
> + * Using direct processing on CQ with non IB_POLL_DIRECT type may trigger
> + * concurrent processing.
>    *
>    * Note: do not pass -1 as %budget unless it is guaranteed that the number
>    * of completions that will be processed is small.
>    */
>   int ib_process_cq_direct(struct ib_cq *cq, int budget)
>   {
> -	WARN_ON_ONCE(cq->poll_ctx != IB_POLL_DIRECT);
> +	struct ib_wc wcs[IB_POLL_BATCH];
>   
> -	return __ib_process_cq(cq, budget);
> +	return __ib_process_cq(cq, budget, wcs);
>   }
>   EXPORT_SYMBOL(ib_process_cq_direct);
>   
> @@ -85,7 +88,7 @@ static int ib_poll_handler(struct irq_poll *iop, int budget)
>   	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
>   	int completed;
>   
> -	completed = __ib_process_cq(cq, budget);
> +	completed = __ib_process_cq(cq, budget, NULL);
>   	if (completed < budget) {
>   		irq_poll_complete(&cq->iop);
>   		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
> @@ -105,7 +108,7 @@ static void ib_cq_poll_work(struct work_struct *work)
>   	struct ib_cq *cq = container_of(work, struct ib_cq, work);
>   	int completed;
>   
> -	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
> +	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
>   	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
>   	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
>   		queue_work(ib_comp_wq, &cq->work);
> 
