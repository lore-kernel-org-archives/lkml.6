Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2699921-1519126070-2-8967929390664303745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519126070; b=pcUPc2ivYnaGh21BG7zhy7bvWR3bKUsbB00RSuVHggXlQnz
    vyzHlfer5WwGUAF+hEsHYxDnUwMOYIuesFJp2Qc8JV/ZaLw1sljm4qzLhVPip4nS
    NPAgPgk1+i9FEfNPe7LHMwyyTuccyJ7mSnEEOZNstavFjqYJt/kGNLIkmnFBZFwn
    zkzIpwHTjF8M93BSnjcfXpJI4A4r3W2C++LyVcyI0HP8effdw4sZwn29y7TFm/r8
    lBpSVznWh2eIgu4MQlLtpBeIjttKS8gVp/2ZvW4/aHNRwoAhwHvDEe38Z0VpYDNY
    HrImcwgk9+carTfyF5C2ZYVkdLMPGFuoctnkL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519126070; bh=w4jHnJxeoSqUoA6Evga7b9aE8l9nsZDHMKNMyOJOVhY=; b=v
    CHlhF74XbnzrBFxxjpabqTUtdHfAHPibawVprQZQ3b8fHv1JRkiPtKfV4ZCED07G
    bKw4nJAbDVA96pwNM7/8rvJ/pIRbgJJqomLLl93+41lwOj6MMAG1kg4NVqgB6L4r
    GyKsVoEbTWlIxw1V9VUKXmgJo5eObiaU09MqjP/J7BmxUR15o4th9MOyvbor21GT
    ykNQEi/c25cIIp1z3AvyCQjIqpcl71zYs/SWTeBGoaGqw6dmcCAMXviG2PG1MJCC
    pzvKI+c6ObjTNOg4tsSQ/aJqRPz0AuAhE/o3+Or7g5fkXg19KlmUKnNwT+aQd/wj
    Knxy0JjfdYZDZxKv+yEug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=nm5gAII7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=nm5gAII7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeBTL1q (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:27:46 -0500
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:24112
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751694AbeBTL1o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Feb 2018 06:27:44 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <baohua@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
 <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
Date: Tue, 20 Feb 2018 12:27:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(39380400002)(2980300002)(438002)(199004)(189003)(50466002)(26005)(77096007)(47776003)(336011)(65806001)(65956001)(64126003)(59450400001)(76176011)(53546011)(83506002)(186003)(23676004)(2486003)(4326008)(36756003)(86362001)(63266004)(58126008)(31686004)(106466001)(316002)(31696002)(54906003)(6306002)(106002)(110136005)(6666003)(93886005)(478600001)(6246003)(7416002)(36386004)(230700001)(8936002)(229853002)(81156014)(65826007)(81166006)(2950100002)(356003)(9786002)(2906002)(5660300001)(305945005)(8676002)(966005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3382;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:mSsJqMLfNJZUYRHl7i/hql9nsVE+HzT0HqvDT+Y99ilymdQpQ5FB1WCmTWKy7HXHKz5KAAKkjAogGSgyCt8HqvRmq0U+WUgZLI4+je3lH/gu0vNhoVfg9Unh2RMQmTCS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934952fe-b900-4c36-b946-08d57854f390
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:CY4PR02MB3382;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB3382;3:vFg9zt++ifHE5d9xu1gcQ/17KQYuATJMs/8aqdJIvXKJnZ8g6E+Qf7AzHHZvqA09Opy9GgopOhxCUQfTlcdBMOFcta4CR0h04qgj4Wm0MQj2xdsJ6FJ7LIH3DkCrCyi47MFDkWLZqU/OrKFgx3rFIPXam77baGD5qZEBHuXErpQwKryoXB9dw+2ami+ZHXkooNsuaf4eCxZsTVFCWnXMqH7n4Lup48wQSAYr2o9vu2XkhVnVwaJBwzisoIBhvxaqQGAeYyHLcz4PmNUbXooCuOPqcO48nvCcgeZYN9wOAX7KRKo7M88I+xgwZmsB0iQNhYFYpYyyEA4JxCOo1NeQzSOOIiziofCa+UFQBTdnmUI=;25:oRb56omzIZCBwBczVmFvzzrIHG7jD6+ovGV/dMzwCqEzRPOXvI6AcZvsgC73dj/Qf8E5moaeyb92/ljeEG5spFfCrHL5uP4ajdHuHs/dubw+Fr6FL2KQihIzrqSgErYmD4vxxplU0i1ZoHucVijYrjlnnYIoPHCLCG++in2mSGzhlSFTLuc8qBTY87IKBZBoXt9R56aFoFr7XFw7VxEr1Ljeax8svfxB6J/xZ3B18NGZ5ZWcdkmBRFW/gNTq/8Euq/VDmZ2a2c08rnoUXsUZe3gnTMCfbmb5+oOB9BBMuJhIkCfDgU/ZvE5ZXd2igDr1etVbGW0kBcPGpWlNx+mYOQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB3382:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB3382;31:f4vRuw5Tw1FPf6e0VisH0XUDwh27EjdHeh2FP49FmJlgFWtfI4pek+eic3lIZD+Oh/hNZ7or3NLYaHArgnGzm96nj698kgD3pJFEeG5zCP5iirTQlxDXEzdCznTBj16T6BDzgKkmlwI+1FrbFOirWHc10LmjUNNMrWgKJ32FNaWQmWybWOEQnnlkW17c1fdDu9K7GEMb6KZFSuZ0JmfwLaneGTQ/k8bMlVxUVd8UBws=;20:4GefdE587N8s53A5T/DK4JtEX6dYFdgpPCNyLqhZNUg5KMVMnLdO4RcUUQ0T15BZ2g17bA8n/fyABB62vyJ2kKp5h7SF5h57tNdc5TEuDG0AM+T729XJ0mJp8oVp85ITJVfWi+PhmmgLnVuDcAq2pKjON7rdERwCt1ZOFpHox9Zhcf9kLF0hQO1agYTleR5ILZOEy6fh8KOB4+SGXFQJ+NOl7CH10Xoi7FC/34KzrcdQc6oawdsFneMl6LvgHwnt10BW4YzJF62jVgCsnhkVRa1YhV3QBaA+Hf2nA49rxSGhuqtqdLK3FOpROLcFd6iqxyL6SQ6PT2xSO+3udLKWhHpOB2pC+Djg4hAEIk0d4sth0lb0mZM9WEkQSAxElFv/HKnd0/yl1iz9Q4Tw4EBeU1+atiaCUxZ6GDXVuKTumjCXF+zta3sR6Hp5l0W6x8zTIEpVpjf9Bkn73q29eEWP5hJIcyXeNbJD/CKXmgGOCOBT3ggfTwVlBiaSHVkEMuUr
X-Microsoft-Antispam-PRVS: <CY4PR02MB33822404A22DF6F619DC1BD9E2CF0@CY4PR02MB3382.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR02MB3382;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB3382;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB3382;4:LLGnyO/DaWnil1ST6YJUbUupidhnk9fOyhALhcu5W9afNZN323It8X1h7jfYOe2U6BI7FQbI6ol60lSntkquLJLtY6EyPf/IhXsUjrybBcTPTRCLf4BbywyT984wKmzb2sd7IARb++NnfTqoa/9XrajfX4fPP6PlLeXtxhLK7JRNieILsXypTFCTLyRcuyRX3OWF/H0CK3Gl1t9xq6ZdAtKlNSp8zAcbWWe0TJYI77QCbJUDHHtHH8FL2AOjlEhNU66IBHwKO3F59JsUn5pk1Ok8osRr4Pa8xkYnIUKwUq2/bNE9RLuZDt/Ontcl1AQk
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIzMzgyOzIzOkdKUGlXaEV3RTZ5ODhsV0ZsVllVUjh3QnU2?=
 =?utf-8?B?MVNNUnQzbVFRa1E3ZUZ5NEtrUEtvOTJDa014Zmdaa0xtbW0zT0hBQ0ZKR0dI?=
 =?utf-8?B?U1hCVkF0NHlIZmJoUW5BWmVoZDVrWkp2WTVpRXhkelJJOGk2Si8zeFdWS0hB?=
 =?utf-8?B?NXFRLzgrc2MyWFdRNWVGcUFIanBKUTZTeStGT2p6RlpYbmZvdHVhWmhxaXpC?=
 =?utf-8?B?WlhtLzgyUExzdjlYdHkxMkt6aEpzeVBCQlQzQjlvOWlPM0s5dUlCeEluak05?=
 =?utf-8?B?dXJuL3NXaHV6b1ZNTDN2d3V1NThlV0FVdWt2bEhtdFJaR2sxWCs4eWNKNURs?=
 =?utf-8?B?dFVRWDFLZDJ0QmRGOFQrTENtMEJYQVV1ejdJNk5TVks0SEpTMk1DZHN6VGFB?=
 =?utf-8?B?VmU1bm40YlBsbzI1SFVQWUFudWowZFlIWDJHeEtHVUxyQnVqV1RBZXhuUUlM?=
 =?utf-8?B?a0QyaXdDOFUxeHMrSjFjdkFJMjZDRW9PZlVtSzVjUzltQ2dOUTBEckJCYTM1?=
 =?utf-8?B?UjRVMjJ2anU2ZWxKYjloMEVkWkR0S0FybHNvQ2hOTGUvd21VRmd6QWRwSzAw?=
 =?utf-8?B?T09ZUUpGcmJJUWlUVEF5V3p6SzRMWW1IN0U3aFFVa2kvVU1HMUJ3b1BGeE42?=
 =?utf-8?B?bkdnOFU3bU1od3BLMGs5V3BreVFDdHdabTJkY0tOYTUxT0FockFkSEhoRktz?=
 =?utf-8?B?MnQ1Z1Jjb1IvUEpJNTJUb2xRNzZsQTRoaEp1MElHajhMODhLckY4T3ZLWVoz?=
 =?utf-8?B?UmhMN3NhcXNNVWhyZTJrMUhFL0VVdWVMa2VPYkh4U1Nkc1dtMFpSeGtIT0pv?=
 =?utf-8?B?Skd6U01BUjJTZjJ3ekcyS0hQTm93RU11Q01lR2d3SjMxKys4TDA4aDBDQzQ3?=
 =?utf-8?B?ODJPTVdoOUI3cndhQ0tENmJTdFA0dTdkM295WFNHV0w2NVJJb0JqR2V4NlFH?=
 =?utf-8?B?dUxEMVZoTDNvT0VVTWJ2K045RlhEZzd2MjE1d2FrVTk4MTNvQ0k4c1BIOUpY?=
 =?utf-8?B?STJlTXZJSnhxZkc2aGVpYXQrblBKcWVqK2RBYkRWQmU2WnV3Wk5Ta2VQeFUr?=
 =?utf-8?B?MmJwTUp3TXhvb1IvQ3JiSXo2aHNRb3ZRZ2RERjJCNXNNMGZyeEc3NVJnTVZw?=
 =?utf-8?B?TnJJR21nUmtxYksweWhnOHVnbnNtczBRcHNRWXh6TGVzcjlYRDhxckNKSGhD?=
 =?utf-8?B?UUNHelRSalpwd0labE9WR2dDSXlUaHNuR2w0cCs1OHRLbFYxUG9BQU1xb0or?=
 =?utf-8?B?dkVzVkUzSVdHbnQzVUhxMEJGZkJjME5yT2pXQ2tqTnI1TnpjZGhld2ZoNXJq?=
 =?utf-8?B?SEYzSmQ2YVZTY2pqSm1xQ0xkbHg3dWdZS1p6Q2lrYU1XQURNNTJMelhCelY5?=
 =?utf-8?B?dzRVUVJBOCs3VWtjWW11Tk1icEZnVVRDUmJFcHErWEY0SFV1TzkvYnh2WE5r?=
 =?utf-8?B?eVJNRDJJZlYvay96c3A3Y3BENC9DcFlCb2tXYUJ5Y2JPcGlOK1BGaWs3UW0w?=
 =?utf-8?B?RGJTNjZZb092TDluMURFdjZxcjhnbU11VFltdmlvWk1ybGpjNDYwcEdYNG9X?=
 =?utf-8?B?WWN5b2ZrRElhRTFpUW5ackhBRXQ2WVVNVG5ITStrN05XNkpDTEFsTUpzWDlH?=
 =?utf-8?B?OHBGQzFBTVlmaGFBYVprOEU1UWRuK2lmZ2ZsSGFMZzJkR0xRRUtocVV1SXNR?=
 =?utf-8?B?dG5CdjZMRjQ3czdWeDVQMEZ0cGE3cHp1MnVacEdvRnRYZ2cwZ2tWZzZpTGdC?=
 =?utf-8?B?MTJFL1dBcXRQakhvWnJ2S1liaU1vWkV2ZXFCa0ZSTDU1ZnFUZUE3SjVuQUxM?=
 =?utf-8?B?bi9Wd1VnZTRLQjZVZ1V6bVBaSElDT0VSeVFoZWtzMlFpVXc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB3382;6:hLLKaDyVKYGmYAo3aSitiziaDFsjAPgMVouwDJYLuDUEhWyPXy2DD2Sw0oTbQEmKLdx3MUAuJq//gqPnnQYp+c6FStFPYCLAkztT9495eHfTESwuAy1G322ZN1fKmxjJC1Qf5+HC1k+SMGEec9WpY3PF9oZdTknx1wLuLJH3ZOtbnhP9G4Q6cVHLYjdXHKIUw6g3iYoONOORMSAVKXdgyePHsS3N6eIEdj18huY1ih3f2W/YAcHi/cRf5rbcjid15iFfJ6lDUv2QHi+tc76BVi5Mrfe1OwfCA1WOGrj3dgRLeogg7g46JvihtbzI/+airk1x8EH01HVSnMxBS6EfzaEsAB23UZgHAxlz+yV5brs=;5:/fzfspJlTslu4Ge1GMjf7lF96rG2bW/52uE0s36w65EUVcmHPYuDz0/YdlfbEqFskFPy1f1l6ybht3JYiLuyPUeGtaThypB0SwKge8Iz5pV6EVW+N1TPwzIprkB3codf/uYxKMHfzZAMFmNRl/zyOVtVT8fLO/NnPZDuMA5m99w=;24:zTK5RVXjsFDQ3OWU8M7EcpCCBacAOHIZxAnIlrE/g6DVkaruXzT/cyiNSn0A0DIKKQ447udNgJiWM8xWIvL7GRoV/P/J1INX3xcqrxFdYSU=;7:FLDI7Pxj+UVlf4yWX7yEVVkBW7KYV8Rf5Am7OV4vCdO6nXK3F6stc882L9v0o0XMLeXdatR1UTM9ZBjlwoBNg3i0A55XxNZUJ7CbAyAwX7P2WglwFw6qSl5Ii/Zml3f9dgyv4GtXUxgnZlGWnN7jUK4eBeguwuipyPGH3GLKijXguuRjbRehae+lvvR9Ivs4MAfMs1UjX/+FD6ff8z6yYSEjDtmqNruXYh0DCjUz69C7VTujhikbZlBcbTILBPHq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 11:27:39.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934952fe-b900-4c36-b946-08d57854f390
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3382
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.2.2018 11:38, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>>> The cdns_uart_port[] array is indexed using a value derived from the
>>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>>
>>> Fix this by adding a range check.
>>>
>>> Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")
>>
>> I didn't find this sha1 - patch name is this one.
> 
> Bummer, I totally screwed up my scripting...
> 
> Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
> 
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>>> index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>> @@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
>>>       struct uart_port *port;
>>>
>>>       /* Try the given port id if failed use default method */
>>> -     if (cdns_uart_port[id].mapbase != 0) {
>>> +     if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
>>>               /* Find the next unused port */
>>>               for (id = 0; id < CDNS_UART_NR_PORTS; id++)
>>>                       if (cdns_uart_port[id].mapbase == 0)
>>>
>>
>> Below should be better fix for this driver.
> 
> I considered that, too, but...
> 
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1109,6 +1109,9 @@ static struct uart_port *cdns_uart_get_port(int id)
>>  {
>>         struct uart_port *port;
>>
>> +       if (id >= CDNS_UART_NR_PORTS)
>> +               return NULL;
>> +
>>         /* Try the given port id if failed use default method */
>>         if (cdns_uart_port[id].mapbase != 0) {
>>                 /* Find the next unused port */
>> @@ -1117,9 +1120,6 @@ static struct uart_port *cdns_uart_get_port(int id)
>>                                 break;
>>         }
>>
>> -       if (id >= CDNS_UART_NR_PORTS)
>> -               return NULL;
>> -
> 
> ... the above check cannot be removed, as it is needed to support the loop
> above to find an unused port.

You are right.
I have checked 4 patches I have sent in past which didn't reach mainline
(probably because of RFC)
Take a look at
https://www.spinics.net/lists/linux-serial/msg27106.html

I have removed cdns_uart_port array completely there.

Thanks,
Michal
