Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/Nzv3APaP4CSNYNcx44jIEfOKW2lZgp8M4vHh2nrUzfjsIVps6GwYGYtI2RSeA2EdOw4dK
ARC-Seal: i=1; a=rsa-sha256; t=1523017514; cv=none;
        d=google.com; s=arc-20160816;
        b=Llt52WS4xFRJJJpqEFdsuHrcAaUHlUPtPITAJ82cIBm6c2zRMHGCzN8pteeHrgG0M9
         KbaS221rbLvZmtJAyJo6PuWCO9qY62Sn+yn5FkqJs22xJ3393q8EUjVZ+3T0BfhCxhnl
         h/wcISkSGj1RQU4rrp+jYyTLO95WnDFPt5XTA/0JxkWLilLE937KG35Vd/yWrilSAGi3
         mmVQ3DkY6ujbjfojM7jkr+eLK1bMnXWQ2XReuVqlAUPAwvOXrR/eYNU0Ez1dSk23W7St
         JR/9rexurHhl1ZqHfXcQ2dn9ZIdSOPomOkgIqIbovy/Kv9/f1s97kGJl6D0em7oijfJ8
         G/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:content-transfer-encoding
         :in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:dkim-signature:arc-authentication-results;
        bh=Ewcqbh2XfdNUvKhTdy6JQ09ounNdKKvxWdpSnxTHzAk=;
        b=UKJP1MxN/QAU9KDhQJl1y7LrAd3Mywj2JrRBwUiv8wrAM6Dp/Rn+Jzm4PwKO0mb1x/
         kQhGA7t1WjsJwFKv1PFmWyb8WHeS3FehnPyEa32qE+yU5mdNkOH10AFMEjFNSlG9kkqF
         Y86Ur8RxDVnfJO6Txt3pEjeaj/RUmEhNzOCfhSW/gIkgN7TD0xgx/P3S26AWFTBWSkeV
         uYp7a91S0l+4gE3ju5FqArHymnk1eCZ0xSGKKMDn3k2h78oVi26hUdAnOUCkl9QSPzJD
         7MBvNPuZ2KD5ohtRv7u8lqel0glmkt13ElidJJrHvq+CvQJdIDKr7k+msEXaDmc8Pb+J
         AQVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=qFhXpm0M;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=qFhXpm0M;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDFMZC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 6 Apr 2018 08:25:02 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:63234
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752125AbeDFMZA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Apr 2018 08:25:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v2] Add udmabuf misc device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>
References: <20180316074650.5415-1-kraxel@redhat.com>
 <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
 <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5d88baad-a956-6bd5-e0d6-aabae6647f3e@amd.com>
Date: Fri, 6 Apr 2018 14:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [178.3.188.67]
X-ClientProxiedBy: AM5PR0602CA0009.eurprd06.prod.outlook.com (10.175.46.147)
 To BN6PR12MB1715.namprd12.prod.outlook.com (10.175.101.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb65551-7191-4af1-ef06-08d59bb968e9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1715;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;3:IPlg5cjG20Bi4u3I/rdqGPidoycurlBbu5XYWvcB2Dw+KsC1prPhDfr7xKvs1IaAjV7+o/878sUH4TWj4Ddyte6ghuGZzCi/bJ55fxkDdOEk/qoNQGJtDLmOFXCpGUCHvQ7i25fYn3/YHmp4Pa8+2NM4a9ih2jH2dMbZPQx8HiTvpOzvpHU77MpicquNSP3/e83/cJ9D2LDRaxSuGgLymHcPJNVnpSN0YX79vozLFq+uXXpOeAgj9wCsdWc1hDFi;25:UjITkWuAx9ZoQSzPf8ugnlCRb9f5cJDsqtFMwX4j+NdjUWdXQKY0sk0Ef8qz4OEMpYk4mAjKQUC4g3vBZqJtWtxYXInS//Y0J/BGB6mlZoNOWihROrANAH8vJR3DJVTCpek72FURarG0zcJDsA5rMsifdmBez3XU+tm7EG48qbbWTNdlYJmC7os6znlHX/TyAcfZLC4richHRhZevOioD6958OLC4goqEXhMOqP0lpQOQXwuU/+NiBebK/VP8sjkRdJSU0pRHIJtSCpxu8iIWyvd2wWx+Gj0hMw9ASZ6ao6YI9LNZw4QXKSsB5IZBV4I3sGqcvf28wGWlww3w6QClQ==;31:HpM26B+efkrLRCTGHhN7cSEp1uaXtBcOW/LFx6GBXdHA9x86kjWeiFdgzQVsnAOP5s/kFRsbbdMWHIpGHMDxcMFA2BaSqO4KWA/xjmm87XaCjl0rUGeeEp14yl8Nx9pp//pyBlRtiIm99eWcw5heJQitjFvwf4/gW0FCFRXPke3paKYoS5vG5471ju2nxrNNYGZqkKndJ7YMRYYE42z4Bj2pZ9GiyXV9iedrZDPPcW0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1715:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;20:gBO7QrVIE16v3wqpHX2Cj2Po9yK48qNTlp0gHFnkpgHF8VJVmJpF4VwW2CX8K9ewpxwlvHQ9E7Ia7K13CT+DJPhLlwOc1EWXY+EENn6GqQYH8FAGP0jjWZkVaBXpB8tIHDbxbXS/Pp2r1fOSXppiMer5QAZPjSyvnRBOkno+OE3+vjhie5geE32JaIo3E9rPrdnRdT8jmNPjE5lfZ0g5/Ii+AuX8TtBZ0MhECZB2NJsgIRYNmPc42Oa7O4GLf9U/iL40WpqnNhpCo7Jq6lQKhoIQHhWGs+I0tXPzI7zTt+iE7bV3qHLpMJj4INXJdasI/gBXBCM9tP+UMmC8TSYqglza1mDOmBzXjkGgEO0+myeqt5n0LpzNFcTGN6WAZsVhUiac63Mf0XoSmXu0jG9e3oD8k+OgnJlIrjK2Cr2w+odYNT6LpWzCd2xa0f7FdxfMc8CnIBT8OsrrKL89vTkiGDH9V4oAzpC02Z4W/mz8JugILbgCcjX7nR/+KuU9Vlc7;4:CZIdmgiCKaTGl+c3glevnnTjzbmEw9S3cIQ9OyPZyYJ8fjCwwKqIAtbbhxZ+P3Cvp13QZyX3HqsOJkKNhWWUOONu8k+2N+5Ozu6NEHM4JxuVIh/yveKHgnq25P193emHLUndy6YPGMLvfNHG3Jh3P24qUUv1rcy8BgeIsFZ062ypuMZtNuP+5o8Y+zc+N4mdNiXNT21SPGOy2zeyAPAxbxcD6K0asGIjH3szqAU2iHzIZ2PI3BsdS3k6x0FdtQ0f62UhHxxQL7fope+Aj04orw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17155B0A6FF465A2CA5D175F83BA0@BN6PR12MB1715.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1715;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1715;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(230700001)(68736007)(386003)(65956001)(52116002)(305945005)(36756003)(6246003)(66066001)(26005)(8936002)(5660300001)(106356001)(65806001)(25786009)(67846002)(16526019)(6916009)(6486002)(7736002)(186003)(53936002)(6666003)(2486003)(72206003)(16576012)(23676004)(4326008)(229853002)(59450400001)(956004)(52146003)(8676002)(76176011)(47776003)(90366009)(97736004)(7416002)(3846002)(446003)(316002)(77096007)(86362001)(31696002)(6116002)(478600001)(105586002)(81156014)(476003)(65826007)(486006)(117156002)(2906002)(31686004)(11346002)(64126003)(50466002)(58126008)(81166006)(2616005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1715;H:[192.168.178.22];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE1OzIzOlJ1U0RDd1lkRUxoTnBRcnhIbG9vZHlCdklh?=
 =?utf-8?B?eWIyd1pRMWRuZFVzbTZjTWdHeFBKeDN4MmVQeFFGbGZWOU5neDZkUklJWUJa?=
 =?utf-8?B?QUpIVWE1YXVHUGduOWIxRitmV0xLL0FDWUpFS0R0eXFCQWhZWkJ0QkdjUUJJ?=
 =?utf-8?B?SzNCQWNUWmxWa3FBVnNYNlRLUnVyRm1jcyt0bE5aMzg0bVlmQi90TG03Ykpp?=
 =?utf-8?B?ZHVydFBDR3VNajZjQTBXY084Z3RiTjFyeCszU1cwcWZ2Q0doVFdEWUxpb1F0?=
 =?utf-8?B?WXMwc0p0TEVRb2dqMmtNd1hNMEp3THRFSk5Fbjd3ekxvQWRQYUFKS1d1M2Vz?=
 =?utf-8?B?REtCbGtSbzhKWkJ4TW5EdWV6Y1hNWkIzaCtvTEpqZVdMYk1rNjNlNnc1ZmM0?=
 =?utf-8?B?L3hNcERkSTc5TmxLSFVsTEFiZUQ2NFBocFRUUDdMUTBmQ0hRb0F5SFBhY2ov?=
 =?utf-8?B?T3k2UW9KZ25BdERPMmI1anZ2dzU0ZjRGcm91bmhWaWZlcUpUZzI0NlZQamNY?=
 =?utf-8?B?Y2NWOEd6d1JEV0pFZ2tORkZtSTdQYTZCQzR0WmREbDFDeXQweEE2QjViN2FS?=
 =?utf-8?B?VUtMTmhZdGNnNEpFMHBsTWZXYUdENXh2RzkvcHhYaGUrMERVanF2M1FQYTdq?=
 =?utf-8?B?WVlQdWtIek1pZksyMGs4WTFFWmkwRGRaZmJaYkRQUWJTVm1keDJ1ME5tdGEv?=
 =?utf-8?B?U1VSRkhTYzhQYStaT2cwQjY3RUFiekRRazYwMVN0K0FralhqK3hOaE9DZnpY?=
 =?utf-8?B?T3hyTFpWTXBpeXpmYmpSb0hCMWswVzhzcVhBTlJhN2Y3WEU0eDZBaW85K3ZL?=
 =?utf-8?B?WDdLU2JZbG5SSmFTRElYL2tGNG51SXFlSjlwTFVPbCt0OWVnTGRScTBFcWo3?=
 =?utf-8?B?bDZQMUhFdTRWNDBLUms3QTNPY1NjTkNLaFRKMEw5Y1NFNkl4R0toOHl1YXlw?=
 =?utf-8?B?K2RadktqaWRWMzJRUlhkL2Uxa2FUWkpBbWtnVzNRL1UvYWx3NXZtQUlNZkFN?=
 =?utf-8?B?eFBpZnk5Z2tPMFZKSHV6M2o1bndhalArRGZSa1ZNWjF6SDFVdnBqcXZOOWNL?=
 =?utf-8?B?am1kZS9aanJPeUFwbHdFVnNRUXQxd1cyYlpmOWFXbzYzUWg2TnFqeFNZV3k3?=
 =?utf-8?B?YXRMNHBvZ3hJRnpNbytBc2dzbkhvWVFwK3RuMzRxSVhiTUMyd21qZGUwSHRn?=
 =?utf-8?B?c3QwWTlGY1ZmaER6RUpDK1dUT01FVS9McXJrelVMbDlmSzZvUGJRbDJKVURZ?=
 =?utf-8?B?YnEzbFJteWJmTjVMeVhDSlBqMGFSb3pZOHkyREd1b3F2bGxIODZTMkhtdDBo?=
 =?utf-8?B?UUFwTXY3VTVtRTR2QmZFbWR5S2toMlNpOC81K21JQkpML0FubkJPLythWGNM?=
 =?utf-8?B?bXl2c3BzaDBUWFkyNzFjQWh6TXRPS2RrNVNYWEkvU01wditVUjMvbVVlR0J4?=
 =?utf-8?B?cFNrZUpnaGZ6TkRBU0ZjQ0JMaFIvWW1KVlE3aGRhem5YSzVURllqQlJtK1g0?=
 =?utf-8?B?a1d0TmhkWEtxSWw0Rzd2WDRiT1hwZTZybk5mam00OVFCYTNvbDVsMjlvOCtP?=
 =?utf-8?B?c1lRaGJ0Zk5wQmRrQmZoSkJhT3h3Z3ltaExzRkM3eU5CbGFZQnIxUkdtaFdX?=
 =?utf-8?B?WVF0NDNXUnpmaW9DQnpHR3BzOGRBS1BrNkZJN3BrdjJOQlpOZzV3YlVtSCsv?=
 =?utf-8?B?VTh6blBBb3ROVWppY1U4dG8xRzk3UXRTNHJOaXBNdXIweUs3UGpLT0IwbXAv?=
 =?utf-8?B?V3g3bXdKeGp5aE52THBzNm90L2xQRTlYNFBvbThONFZGUVBOVGJNUkJxV3BP?=
 =?utf-8?B?R1RoL0lmVFUyNjYwVHBFbkdaeEpCUnhMTk41ek1JeTZQOHBidDJVZERCdllV?=
 =?utf-8?B?eFBKRERrTTB1eHdabkhSY2duTUhxZWd0TzFuSzVKMmFhN1ZWZ3BDS0Q5Nlhx?=
 =?utf-8?B?Njl1L0NnKzVzeEg1dldBMEJIdG5jTVdHeUhaTldOS2J2dkN6a3c1Z05oMHVr?=
 =?utf-8?B?SkRZWFRQQXE0WFpxZHFjeG5zZHdWZXp2SHZqYktoYjRLbmxvZjRoZVRONXpj?=
 =?utf-8?B?ZlBrNCtnQzJqMnZmQUJOU1ZISXFEZmE4Z2k0aDRmQi9FaXVaR2Q4MDZuZndy?=
 =?utf-8?B?NGc9PQ==?=
X-Microsoft-Antispam-Message-Info: g97MSw9wq1DJTeWaiNZUs+2tccySBLh8w7A0FcqYhIVHxN7tI3gfkNJFEQy/7qO9OCoogHkuv/PmoSmvy1SeHBez0copF9r1DVSHCV38NcYk/KtCTTLiSITVC46UCDiC0igpC1o0xmP4eQNnjqCi36i70sgW3wmbwkCA58nXvbMg7Cu8m5s2cnV6cHjRTwNC
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;6:AHnXTif7+hyvyJ1n3vaIQzx9hVBZtuOjRGy+0Q3ae05QFUyoOOwU752YJbUcF9lcGZBXPECV2wFyZapmk5ufwS2usPHME45LQ/SUNmqBh7+fQZybW12Wyol/1NixY4rB6UjDv2eZEFGlpDV68WpYtwJpgTeOnWaKSfizqc5qYJ/slgNi7jIBPft2+9Mj0ly+HTiAUFJzbhqXHTFFS/yd/fQMXNo1E2swy7GZhnUtHdX6X5dqkA2gr4DQLUnBZk0gXcS+rf1rx01LG4jzNkqv3+LynYOjqC9lIkv3aCagoszYvNVkVh5KU+un6UC9/vRLIEh6BffBScFWbvIBWKA/0jYFL3Hv6FlBJX0k47dDHCqajwWqXMVxfV4o+AERqbUZR7lKHVAHxyuhDHQD9kJ2wBt08CDn57gKvwR1Es1lvxyoMALRNb87dbRVra4XNoMaOePZLa5/pa0MO2X663dfqw==;5:9HIl75t9DkWvMWbKgq5pIz3+HAMGEUM16VXcAwEIY69ZvK+OnVCJlomNe2YswB3ADVDInUHGZKbYEJUl03C0VN3TZH0oUChY8QUv5oRQFKmf4Kfy3e3yBPf20MLm1zWogTpot9oP3hbCV4qld3FcJMDrrTm6EgYTwSxpMQgxoKs=;24:EJd65bzE8PYDK/LfsYbZ+zNTJ7d+uy/p6TDIrEjiOELeQNk24Sx8W530I8V3Rzky6p2R6JVDc+Y8WZNDOTy6IHcTYUg17D/0srz8zDSUHDU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;7:nZJwtKU1nS4qeN+6T0j9+FxhKg2bsETT1Vg2NV7Gfe4sbw6giX+zf07/gkCQvLTZfWovDo1FXO3pIZWpXcn5lNjYai+/E1BIsfg1OBsnRcaC+K0jeNwqCU428XqxjFtct0QcLzPw9tlNG/yfcz0fzxrMF2+GEcth/jwMO9OuWFeFp1aJALP0aGWoaV7ze/f2sUk0c6gaNHQF8QmqzdjqyPd5aQBbWJ2zJ7091/POBtb1W1agODud7m6lYAh/D91P;20:chhGSrnqdeN26aCbIpAhevgTvpOYRXBO5/vA9ONYz/34lKgQLj8+HKJeQXfSgnq71GlyAAwDhKMQyp92m5Numf7yf3yLaopV/xUd+XvDIYwULdNAru+i1iZb7iKoPFGe9PLtjA15eVVhAlnRC+fpwcf7j6K7TH0/52bYESqvy2yhtUbRgZn3rHQEMjPDBOWgF0pvmi7xp15c8/brYmFBamOEP+T8KRGJjMhhp1g96ePBPlHXj0CJUJOOlQZfHZMK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 12:24:55.7035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb65551-7191-4af1-ef06-08d59bb968e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1715
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595079572079958094?=
X-GMAIL-MSGID: =?utf-8?q?1596999613133152477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 06.04.2018 um 11:33 schrieb Gerd Hoffmann:
>    Hi,
>
>> The pages backing a DMA-buf are not allowed to move (at least not without a
>> patch set I'm currently working on), but for certain MM operations to work
>> correctly you must be able to modify the page tables entries and move the
>> pages backing them around.
>>
>> For example try to use fork() with some copy on write pages with this
>> approach. You will find that you have only two options to correctly handle
>> this.
> The fork() issue should go away with shared memory pages (no cow).
> I guess this is the reason why vgem is internally backed by shmem.

Yes, exactly that is also an approach which should work fine. Just don't 
try to get this working with get_user_pages().

>
> Hmm.  So I could try to limit the udmabuf driver to shmem too (i.e.
> have the ioctl take a shmem filehandle and offset instead of a virtual
> address).
>
> But maybe it is better then to just extend vgem, i.e. add support to
> create gem objects from existing shmem.
>
> Comments?

Yes, extending vgem instead of creating something new sounds like a good 
idea to me as well.

Regards,
Christian.

>
> cheers,
>    Gerd
>

