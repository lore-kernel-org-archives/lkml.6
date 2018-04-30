Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZrT1uMs7OrOhwuhqB/+PTCyQeGHYoH4NlaEJrF1aL2ieg3t0mIH75F5Tt3awwBaA9sYvKug
ARC-Seal: i=1; a=rsa-sha256; t=1525072989; cv=none;
        d=google.com; s=arc-20160816;
        b=zeHo12TAewCrO0iyg3yP6HX7/zmCjWktAcSMo+C6MtLyjNz9nAJbx1G6rSZc1J2zXG
         LCwIv9SNdEgQatTsqWmmNQUfR7p3ZrGHDSzhU5k/EmDYLZ9f6c42WS/szklljTzHb71U
         oq+YED6QgIxJmw4AoQmLuR+LYH8soa8C3aA6jgBInnWiIc6DUfkFHypwJ6N3Du8G41Ep
         th3UOloUeyqBUfzfDYoQqibRRju+oNVZziTTNrEonGfZQfQi0rluf2E8inAS/nwrE7z2
         HKNYYTCNcGBFYxzbv1xv1dIVWfwlgf/s7ZcUfJubLgExorMUvh6XowbR0KBGfDh7KMxT
         eyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=0lRrehbl7JC3MdBmjK+WWTNWadKC1i0uw1FOIOKUFjI=;
        b=oZLx/x3sG7ro0kB/g1xPz8UrTqQACF3AOsd04TNuMTxtGIJpR9mTcVDiMrSuzbLMsl
         bPa0JlrKLG7WGekGmlqo3Ia03Cl18FWY8pxMd+Uuvgdf54O18/LEhierf3bhfCycIRsc
         QlvpgtMGnvgtuBOPu5pJrskM2h/DoqJYZ7wiaD3Tn9WokLEpKBJG4h2sN44FPq4kC03L
         KCt49M2CykvlK+EF+4Wrxq5oEK9KoFOPiN8tOVWl7cmQ2I/Xf6wPNFCkhgcEmAfTuw43
         2BNExihYm5Cl41JkyYHizHg9kn4Ht2PEidzFxS9tcsTJ1Cz3fK8sFaakpUKMpPZPcW9Y
         LSmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=lGnyqrRR;
       spf=neutral (google.com: 104.47.41.69 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=lGnyqrRR;
       spf=neutral (google.com: 104.47.41.69 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH 04/11] ASoC: amd: removed separate byte count variables
 for playback and capture
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 jclinton@chromium.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, pombredanne@nexb.com,
 kstewart@linuxfoundation.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-4-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omA4DNm7HZZUpRBJfhhY-GYGaQRU1KWBb-CTuO7qGwTXCw@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <e8f39d50-360e-cd66-aba7-8fd1aade6f49@amd.com>
Date: Mon, 30 Apr 2018 12:55:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omA4DNm7HZZUpRBJfhhY-GYGaQRU1KWBb-CTuO7qGwTXCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To SN1PR12MB0319.namprd12.prod.outlook.com
 (2a01:111:e400:5145::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0319;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;3:bBx6RaLa+UcG8+s+gCA8zDyG8tbuBNNDF6d9deOi9H+Vw1gS/IiDY7/0h5ek+gFa4c0l+swj+STsPXalsu2gjRkoc9cbC4krFZXGRHlXmSWKLEvsILOuJM4TMaoinL2LBJ76oQivT2J0B0tPKI3ppNhb3DPT6lZcYQ/eZeK/7bDR4HJklRohKjmUfEsij0PDw4d47AOCOAo+E0FcEtF1yPtR0kx2hegLOwv6Wa1DjTJteOm74+ZwE4gbzhp7cF13;25:VTSwG9k9RaobJ1Vpt4NyXwei1zsBhqlHh2wUoo7UN17Ne1YGEF+nwWo236x5LRvTSDASgDhHlqtfhh4WVQGNsHkzyL6N84GwZA8kusfd1mEaGeZczXt+PaRMZFV+vG0ixBDqLTx/xcXla+W5QwmCfve5MAJn6u5D2pWRbve/WQOcFsL7k9iWkFQAR4ifDP3/ikmsIRsXLJYBB0JUlEiNPusMuskQixAwRJTFZ0wrY2AGPnpXxbbB+9A/vUDHx3cEA8XOgfdsh5sU192gOt+BC93uxnTaYO3vSROfbvrjqfkCUVrFeJJH8N4999ySwH3qfV191gVRfGAqHFUIYnPsMQ==;31:7kgCNd9ehDQr6Z9VYUM7kHQFPWsVvE5DVGlHG+kS3LPFetBDiKeqdPN3cKmBhtJ07RrKnVZFazZHLGhrB9QNYcaLA72F/Fd/tKvb+H8EeK6ZvT6nOfbpJX2T2v4uwnI6WDhHAr6yQcDRdaBb48mPSCXixgb/6bY+0eFwGilnlUUAUnHyS9fL/mccNgaf9OXy1wIXzCHjZOw/MPBzCuszD6R5NHGpezv50aXfWsZtsTs=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0319:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;20:JrT6QoX/dfljwaIhxwwN3tAeHXDe0/revmf51vWlj8g4BILLbm+ymv9wKsydY7e2Eu6+RfCJXnjIsNdICJqOokSNko79j+ztvc4kW9Alzyqg1YK0Tdsr4kPmrC+ihWOafj0thSyTnoqwF5kB7JnCxV0wNhbPPgdQ6CW+c5CNJFHZqhGvbk2eCgI1SOSJivaSbVJ4Mz02mouQFdrlnRIRnPvYJAVK7hvq0ltckZzcKPK7qV1FJVrhfUiV3+sDto8009RfryRaLwO4BqkvJFop+6EFWskR2hoeqkveEWkK+PPiBx0DbfZl74+ayCdX6mHHIm6fH4tu4UMmtNPRwAm6RncDK3UpYtWdGZeXfk0lrVsJ82W0KIWnOkshpi7jLp9IAQ5bhclhlwQm4ktDrkmpY+HvFpSCfeRNoCvi4VJM4+115ZAq9diRrqW46uRyH0bdRqsrw66G/uK/CVVpoXd9IBDQS8RIwRMTmTk34MM+lJgGkYcosHAs2CjiYAUwZX0b;4:jvJe5Wpw+TG0hsoFPyFkc3O8vdeZFJniEvXs/woFpWPwcd16E0p2iWtAJdiwfQlLgqnqYctjnX/zZ1IPACvVwCq/guhQINfOkBpt7v3fF7YQ4INFoXLLs4kYl8OBzQRXWnh3VaFYyxHgWo13n5mdxwzb3IPLscc+400epIrF/tQuBVz2gk8byRdUwD3SKY2aBNg1Rd8KzXovWE9F+FV0fvcEZTSXvD5oqQNvTLfSN9Ue6kJR30jBJJvB1W80kEKfpVVRSrjSYK3XpV2IdXCGEVF0rdCXZJJ7CrSM9xlbRe1zcKY7A1l4j6yanFQ/8I4Y
X-Microsoft-Antispam-PRVS: <SN1PR12MB0319A4FC5FB8CC5CEE8AA24A97820@SN1PR12MB0319.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR12MB0319;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0319;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(199004)(189003)(3846002)(81156014)(6666003)(6116002)(66066001)(305945005)(446003)(7736002)(6486002)(65956001)(5660300001)(81166006)(186003)(16526019)(64126003)(50466002)(65806001)(47776003)(36756003)(65826007)(4326008)(8936002)(25786009)(386003)(7416002)(31696002)(76176011)(486006)(86362001)(23676004)(8676002)(2486003)(2906002)(52146003)(229853002)(52116002)(67846002)(6916009)(58126008)(39060400002)(6246003)(31686004)(53546011)(72206003)(476003)(26005)(77096007)(11346002)(316002)(16576012)(97736004)(2616005)(54906003)(106356001)(230700001)(105586002)(478600001)(956004)(68736007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0319;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMzE5OzIzOkNmbE1IRmNvSzhLamp3eGR5YXJuRUN4OC9t?=
 =?utf-8?B?aXF4aWNvVzR1WnJZNUVNZVE3STErV256SHNFSEFJdS90MWhiaTBuZkg0VGFG?=
 =?utf-8?B?UU1mRVcwQ0dWb0Z2UWJhRzJSdmFaTzErQzNDNkorWStrb2swOGNuQ2xhMlNs?=
 =?utf-8?B?azhnMGtvZUlvWThhN2Y4b2hncWpWYWtiaG0xSFJhR1FFM0hZdDI0YmhTRVdw?=
 =?utf-8?B?SjBCVFphLzg2eEZ0aGlPaWJNcjRvbUxKYjE4b1BjTWxBMGlXcS9mdXZYMjAx?=
 =?utf-8?B?dEZxa0dUTEROV0E2ckMrNzI2THFoeDd5dGEzb29PVWFCR2RXTkU2RU1SL2V0?=
 =?utf-8?B?czNsR1JzOWcxWndKK0hQaFBqakVnU0dhZktuVkRjM3AwTzQrMHF0ekY3Wllw?=
 =?utf-8?B?eStHSmxDQ3IwQUxGK05PMm0wdWtmRFpVdVRidFhmcG90VWc0YlE4cS9vekpz?=
 =?utf-8?B?UjlSVVZ6Rm1BakhSdVp1U0JBMWNkUmlUOTE2TkVBWmh3ZW5pM0QxMjZoenJF?=
 =?utf-8?B?ZHYrVVZialk3MUZVZ210STRSQ2VXT2lURnorTXpIMDVSZDNoeDU3bmpYMDBT?=
 =?utf-8?B?Z1J6eVZOblJXZ3ZxNGRFUmUvN0gxU3dvWmNBNVpSMUo2NXJpQjAwdXdMRnhp?=
 =?utf-8?B?dFVNcmV6eWttUzFudENudjBaa29FL2pKSDhMQUQvUnA4NzE4eEhWRmQ0R3NJ?=
 =?utf-8?B?WDgzUHJwQVdNOWRnMVBaTWlxb0VCc3Q4bFpKQ1NJSWR0S0FLWmdoTkY2NDQ3?=
 =?utf-8?B?dE4rR1FiTWx3NWxNbC9SdHhWdzQwWkwvWkJVMHcwdDc1ZHlEd0pvMTRQZlYy?=
 =?utf-8?B?MWdlSUQwcjdjMjQrenR5VkQrMnliZXJONk81UUtCRk1hSmtOcmVFaEJyYktC?=
 =?utf-8?B?OGFSN2JSTldkWWNUN0ZCYW45K0FqK096cEhKR1I3ZGpNZkJTdU5XRTVZOUUy?=
 =?utf-8?B?d3RYbVZ4WE1Kb1h4dkZTQ1NhTFhnaWFGaEhYZm94OWEyeTZRMWpWU01RZUo0?=
 =?utf-8?B?dXZmZWxFbWRxOGorbUxzb3JHc2hMR0F3UHZseXpOUU5BSk9LSmlML0doSS9o?=
 =?utf-8?B?MzhIZUpySG1Wc3VSZUhpV2dYeTA5eS96VEF6UWwxWHVoQU4yUnBCS052SDI2?=
 =?utf-8?B?VmlRWkEvUi9maldSRnNqdzVYVWZHNlJDMm95S24zWGZnRDFrRExTU25UZURF?=
 =?utf-8?B?ZWJlTzZtUmJCaE5jb0Y1NGQ3enZjdHlXMmtIdlVGRFF3alI2bGI1enE3Znhp?=
 =?utf-8?B?UTFRMm0wT0VsZVB2VWJrak9ZbWJtZWIxVHNvNWVGQ29sOEtYYVc4NytEb2NN?=
 =?utf-8?B?d3IvK0krUHRObms0aE0yRVUzT0JnY3JURGMxV3IwRTV2ckRzRkorWjR1Mk9v?=
 =?utf-8?B?eDJjQ1RFK1RBcHZTNVAwTEFabHdVTkw1d1ErNUlJWERBY3lQWEdPRkRsejNV?=
 =?utf-8?B?cFdJZTUzOWhKMTZpcGRzN3NvYmF6TUZUVWswT3hjejRRaDFGaVFzdHd5SXlH?=
 =?utf-8?B?UG5tL2RoemM0OVRzZVJMYlRZU1FNdVlXZkxwa0hNS2prRzZId09NTDlSeENk?=
 =?utf-8?B?YzNNcE5XOU9LM0puaWZJZjltd2JqalJuYjFFSEd1V1RpcVBURVFIdkhKRkV3?=
 =?utf-8?B?cEdIWFNWZnNtcGpXUWdGTzBJVkxZa1A2S29QczBPUWJoNkd0cUhjVi9pVlJG?=
 =?utf-8?B?bnAzRStJTm4yT0RBSk54R0p6RFZ2dzlrNFpCQU0vQ1hSVTN2MS9tUExzQmpq?=
 =?utf-8?B?Z29QcGhsUXEzSHd1K0h1RzVjNkc2MFIzcDdmeFFtMVZ0Mno5cmxwVDBJdGov?=
 =?utf-8?B?eUN2ejd5YXRqbG5uY3VhbjBDZVJvVDVLenQyeStZcWZjdEpXamFXMDZid1Ro?=
 =?utf-8?B?ZnBZa0doL0F3NFMyUVVDeUNYYndDMzN3ZmR6SWxSUTg1amt0K2pNZis1MzRM?=
 =?utf-8?B?ekY5dHBLV2x2OFF4UHVJYkhteDZFYUFWSEVTM2JkQUxaVldQODFWZGlKc0Z4?=
 =?utf-8?B?eldkQnc3ODNJVEdhMVBpbEhmNHRWQmZCc1BYb0JnOEZzRzdOMDA0RUwvT2Na?=
 =?utf-8?Q?Bk/iaHYX98Rwv+1U0SYEYkwRa?=
X-Microsoft-Antispam-Message-Info: DnOw9SJC5wqJBaOKqcrqPqrCin73dp0f3CH6CJnS/BtrixvEMiaa4jUqZt8vySoGBRcPSF2zBp18j2SPZZMNeXQSB+x2pVwv5ONIzoEGkqKSSMQ/VjynLNYisy/hiDSV+y3wU72+zeJrmgKdu5hxPXRwXQMFKFC2n7okGglenQ9bxVerhmNzScWPfAZsx9Ze
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;6:3rEc+7hzYH7yn264nJqgFxDGnjKazlzYZ1Yw/phfHH5Ubpds9y6SJVNDbGRQ+RFsB6PQOttesynE3meCJS0HNTplkz13m3gpCa9PFToS/difrL0qsxHbZS2avjsP0a2GID3wlBbzjSKPbbITymzFdj9iGFBY8/sJ0HB4mCg29zM2hsTrgwnXTKYn1B10LWc7wKrQ7jmZ2s6FeBwKrJygb2L03QXcUdC1eEduNhVIUD1uCIP5mVqjQbxJJH4oNH2Auxr4jAetJjLTlCNViYA+sjzE5mcBW6KBddj8xpJFwhE4hLONhLeLHUEy/YqRzDysPslE9kWM9u8nYLnUsvqIsrATUeox3hAD8+2vZnm6heV+01BM9VqeUit8sKTwWAd9+GHL1g4CqVsmMBCCUIesF/v2LNbT0ehmVpu8/uSwSFDHmQyNGYgtjQ/jPAPSiRtDxew4dBwlYB1rGZorKRjMJw==;5:Npgh6afGzFZ4YXGCRA1OI2JaszoX+eMiqW+zxINgDdRBm1YJV0aBq0SPxMNPWDA/l281VEf8ygXHwxFIHK8wKAHTRB64hrc6bgIwB1Tx1bl73ti52vRvLDdBc9/ec9hbBGE8SiG6F34cK5rRZSn3nK1VuGAXkXalIcdZcKxuBfE=;24:Pv0xHoUZAFU0nGOpCXDTS34fORYsG5o08jEitjUT+KmEg7Xhy4ev2099xgMr5gHMc4xiUDKDCwUu8ROsvhoH2qro/1XwDLZDej+IjclB3UI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0319;7:JlYqkkJ0Wlb4mKRQjzJBpt4H2ly9nN83XfTXrvdnUlGWpCK3lOjD3CljTrQ3RAJ1CXIC+y57/HKSbNSRdJShm4lomHhAzNF/n+ll2VYNLvmDP7/kGXk9npw8f5PPQnEtAsXYPDEdbSBdLJPFRr9w7lTUUcfS0q3qRzcXj91MRiOVUtywilgbStixqYGl+CNfY4TKMyJ51NVcQi5sBnY57fz4ND5JMaBJR7o5RbhBK7lyz9mZUgakrwIPHv9z2U+H;20:4XWp1ayXDLrKqHTtrQQQPNMgUrvqQs2k7XUD9wn/6d/nQQ3pWHx76ogIp0k6HZAYfpXdNwy5zVesgsob0/0cUOGcqvdLDpjTkwsOa9GzSlD5udNJIyQY6hjJ9gjKFvlX8yEUtxQfrtS+V92B/0evvMShWIVlU9bro/pfxKJKWKYgPr8ZhJrH8l0mP8t/H7JcdtdeFiI2cVa3EPbcnj0tnaqEz62mE5OeQKwlZvW3fhSMY9tPTjGzrUjidDPdEYGl
X-MS-Office365-Filtering-Correlation-Id: 5e2c70fb-9e7a-4cc3-ef50-08d5ae6b37a0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:23:02.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c70fb-9e7a-4cc3-ef50-08d5ae6b37a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0319
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807163736514743?=
X-GMAIL-MSGID: =?utf-8?q?1599154935044290202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 30 April 2018 03:11 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> On Thu, Apr 26, 2018 at 5:15 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Removed separate byte count variables for playback and capture.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
>>    sound/soc/amd/acp.h         |  3 +--
>>    2 files changed, 6 insertions(+), 16 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 019f696..5f34be1 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
> snd_pcm_substream *substream)
>>           buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>>           bytescount = acp_get_byte_count(rtd);
> 
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               if (bytescount > rtd->i2ssp_renderbytescount)
>> -                       bytescount = bytescount -
> rtd->i2ssp_renderbytescount;
>> -       } else {
>> -               if (bytescount > rtd->i2ssp_capturebytescount)
>> -                       bytescount = bytescount -
> rtd->i2ssp_capturebytescount;
>> -       }
>> +       if (bytescount > rtd->bytescount)
>> +               bytescount = bytescount - rtd->bytescount;
> 
> nit, this could be:
> bytescount -= rtd->bytescount;

we will fix it and will share fresh patch.
> 
>>           pos = do_div(bytescount, buffersize);
>>           return bytes_to_frames(runtime, pos);
>>    }
>> @@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>           case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>           case SNDRV_PCM_TRIGGER_RESUME:
>>                   bytescount = acp_get_byte_count(rtd);
>> +               if (rtd->bytescount == 0)
>> +                       rtd->bytescount = bytescount;
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       if (rtd->i2ssp_renderbytescount == 0)
>> -                               rtd->i2ssp_renderbytescount = bytescount;
>>                           acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>>                           while (acp_reg_read(rtd->acp_mmio,
> mmACP_DMA_CH_STS) &
>>                                   BIT(rtd->ch1)) {
>> @@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                                   }
>>                                   cpu_relax();
>>                           }
>> -               } else {
>> -                       if (rtd->i2ssp_capturebytescount == 0)
>> -                               rtd->i2ssp_capturebytescount = bytescount;
>>                   }
>>                   acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>>                   ret = 0;
>> @@ -947,12 +939,11 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                           acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>>                           ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>> -                       rtd->i2ssp_renderbytescount = 0;
>>                   } else {
>>                           acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>>                           ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>> -                       rtd->i2ssp_capturebytescount = 0;
>>                   }
>> +               rtd->bytescount = 0;
>>                   break;
>>           default:
>>                   ret = -EINVAL;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 3b076c6..82470bc 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -93,8 +93,7 @@ struct audio_substream_data {
>>           u32 byte_cnt_high_reg_offset;
>>           u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> -       u64 i2ssp_renderbytescount;
>> -       u64 i2ssp_capturebytescount;
>> +       u64 bytescount;
>>           void __iomem *acp_mmio;
>>    };
> 
>> --
>> 2.7.4
