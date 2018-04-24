Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4+kyDsr+mXFwOoIvcrK6aOlyQNzZYI6pPW52hDKZszmgKrFyEJb98bmST7lgL3ps3ytsv3O
ARC-Seal: i=1; a=rsa-sha256; t=1524553456; cv=none;
        d=google.com; s=arc-20160816;
        b=OJ5QU52fTtH22QKVdl/QF5/AnYRcPlsXrdYNs5/UGR8efrCWrMFOsOH5uOgeVaezy5
         hZhm2h+UvOVbwiZjLkuS/5cph0nkXk0N/eDDgis/5+i4eEoy3treZ7PfhSEO9EfKo+LJ
         +TOckjNpB0AKFK9HA+2x+GAzRBZH/4Qt7mpwdXYvq5BhlEzWr2I70UGtJY0DSx6Tv+tx
         mcIJbYMXQ9zB/tHMIGQJgmXfMSeJGUmwFdRHYglbiaFsF9mQ1SrB+zx09y/oqNOaFZlg
         l/S0AP4G7syrAjcPchYsorsBXsuoX6nBl5TMWvvreGDDleEyGigiStjru7GKel0t2wui
         9iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=0s2wLfBuFT/enQzItJypZiPAE9PJ7VAlfMgIq/hLt5U=;
        b=Ui7Wy8X3pHXpg5TQ+aPKbf+C747/P9Lgaut9zDlaNtEUiLL5kJxJcPrSGm4Ielon6E
         TM+oW7LR526/tPyOKhcrWLdLXZOWc2J99h9v3CfQTR2MJKqZkkvGEl04mAkVYLPBgnLx
         N59OnKGxjGbN5dM/UPo6z16U6krTEQQJVvx6i7FeQ6vojzWRcQmPXBo1n7cowbKnamY8
         Na9KMxor4wx8GFQYfBQQfLGs2GCqYitWEhGlZJ9IIUSO8vvODZmko0GI0X2Ou28XQNEc
         Q4hQ4Biy3Vh7HA0iwlsu2Sf8Upc+bnvv83QGMxoKe4SUZsoEM/vDod3A/1NgInW537j0
         Ollw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=hlNHW4Hf;
       spf=neutral (google.com: 104.47.36.67 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=hlNHW4Hf;
       spf=neutral (google.com: 104.47.36.67 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH 1/3] ASoC: amd: acp dma driver code cleanup
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
 Guenter Roeck <linux@roeck-us.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omA0Um=borxoDSKzsq0UjATq0cPE9DCZEkokhLK__utEpg@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <b48460c8-1180-9fe2-d614-5b7691975c43@amd.com>
Date: Tue, 24 Apr 2018 12:36:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omA0Um=borxoDSKzsq0UjATq0cPE9DCZEkokhLK__utEpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::31) To SN1PR12MB0320.namprd12.prod.outlook.com
 (2a01:111:e400:5146::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0320;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0320;3:Y4x4VTlGOD+xU/SCaZvKOOPuGj45vBlfH5XeNkQzNbVup66xDQXSgprgf5hOMG3E/4/JASVjFx8f51WH2zp5FEOlSZluppqa9rPWRcjGIYubMWHnSyySj4gy51a6MT+pQam8WGNHnOS7GT2T2wBJTwrluxIzr/JJDb5sUyE5f5xCf0cs0F+M0DVwWQhkkxiUAGUZjn8a+GJH3ByLvWs2MbGpRrxObBsEMNEWSd2Szs4E5scNXwTkvXfrq9N9xtCl;25:RG2IgaK9lrxDrkarJjywZwJaGtqw5wfJ8tAYKKT63TBjYmqPfqlijSoWMPgZxEJ/1Vn6e9c27IiSkFORC/EOyRXN78qE1Eo0aUm0NINf5YRZKWGsxcPWMfZP5YdQ1J464ZuO8j34EIk4N9J0kjdbO6Plos2AXlMlLUbGCTN0jkjqGjdHRzbFuU9wdoIqUEDd9XTZOKkDNMVtxP/fgF7Ggu765iV9eNE+EzU9nu5DoMAH1xcxICQftO9kZWT43Hu1FAO/3weYmtBkXN5azJ28nBRbBnzBG+n5aG78l3jnauqI33bx90J8Vb+gbi0pf3IFtMIWj4pPxHawLLm6a5266g==;31:32NT+kWE5p9CwvOAuM6jfqPui+oHpK+s4bRImtdBPQKkQiWdBIGqq6tSaEdYuSmtylH4btMdY053+mnOh+jN4Tmjlipxtiu4pYKs6XryIek5mJZS3pHbRSI+l1QPzgJrPMQjWfA2dedbNntSElM/KPhDAwRre/aSPYHVLd1mdXF0/xylUIE0sXjNABYy8wURf7US68B8mBgBL3S3ripBvkIliElLNjOM8NzD4LtiMyA=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0320:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0320;20:lRi/6xQOBQd+naIG4N3KVjzepglyVTOJXa0pa/ze9teLKO5Wp1K7GPrz3NrGGj/JUXWupfOCLigQMOX/3dGIPfZDvqoUsiTSZ8Vwu9CaBVxKdNmqJI+xrenjNIh6F+UIcd+yEnqdEKhTpnS2iQ6WfQEOOVxG4YlOpVclZ/oGuZmGiR71mYMoLTK1nEsR6yPZPL0v0VWkJhSZt77/rg2szX8fzoNTtrYl3xJtw1laSmv6J4+9Xa7lqYTeRUr9rxHBF6A5aNmnU6D1srdHXXuSgrrb4oVDTlCVwU+FIS2UyEXRb4V/3D1o/lYbizI52HHgp+GO5PIVkssFFXBdRk0307EIY5IYpq2CtIPAs9ha+qZw16Eqijr557fGRXT9Xyzgem9hl92y4F5b8JR4Fhz+RMdHl+ckG7A3+/EBQUwlHUQfkg1qo69QbPdVAElB7HspMtTyedbAp3U5jDkVDaL9rLZoR1oyotMRQC8Y/MXjAiVwBgo+ScYZtd1oiwZVUspn;4:hEnSeZhoSw4cc+Cr+5hrEnUlR8cANzAXZXwRhi81jvPDS9q0JtmWlRYYuJMfHZEshEvNm/hjXELhXN1M0TW9oWUMB2kusnHb1ogxEES8bLMWZnGfbFKLKze/sn1Fg44oS+QpTuIOFiFJvrgAMpzkQSeGjpLo4fznObv5sh4uCNl4Bm7fK3a22zglP8BkLcxgcTmW6PygNEYgjypMFEMGIPsbH7RTLm2TYL2I4yClAgZBMJbjwvNbQ1lWpT44zj6Nl9+HeJiDH6sD6wee3tcRh57VSoUm3sG6XayWXd81vNjg3vRu2pveEQoPTXqxvR2e
X-Microsoft-Antispam-PRVS: <SN1PR12MB032013238C957A125BD712A297880@SN1PR12MB0320.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0320;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0320;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(396003)(39380400002)(39860400002)(54534003)(4326008)(7736002)(8936002)(81166006)(54906003)(7416002)(305945005)(8676002)(316002)(25786009)(58126008)(5660300001)(47776003)(16576012)(65806001)(36756003)(66066001)(65956001)(2906002)(478600001)(65826007)(72206003)(230700001)(31696002)(3846002)(6116002)(476003)(86362001)(956004)(53936002)(2616005)(229853002)(6486002)(31686004)(39060400002)(6246003)(6916009)(67846002)(6666003)(2486003)(23676004)(52146003)(76176011)(386003)(59450400001)(53546011)(50466002)(11346002)(16526019)(186003)(446003)(77096007)(64126003)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0320;H:[10.129.12.246];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMzIwOzIzOlBDSlpQTHArOTdnVTZ1M21ka0M4SUJDcFli?=
 =?utf-8?B?eUlwUlVlNWUvZTA3OE5UZll5eHdmK3Bxbzkya21hUThSRCtpSWhmS3VJNGNv?=
 =?utf-8?B?UVU5dTgwSUJZQTVTTklYQm10T0o3djBlNmRMMjJScVVMTnoxRGkvRDFxbHR5?=
 =?utf-8?B?VEhlbjhQQWtkMUEwNnlHRisvQVVtRVNOdHpSNVFrSGw5VmVGc0xMY3ZHVjl5?=
 =?utf-8?B?ZXppbVFqUmc5RjFadnl3eGZzdndZYlpIZ3A2bEpDamY3dzE5Zlpsb01zM0p5?=
 =?utf-8?B?c3VkMFNiVFpzRlBIL0Q4bEJOb2JxdUxFSG9PZWN0akF4K0E1VVdxNWZrNkdV?=
 =?utf-8?B?Z0VxMWQyRC9HR0pWWUIwd1Q2cFZJc2xJMEdDRjZGWkNPQXh0UXdNditmaU9Y?=
 =?utf-8?B?VkFBMThDRWRDUGNlU2N5aks5SDhUbnhWeWRmUUM4WWJiOTBVaThpcC80YlEy?=
 =?utf-8?B?NTZXNUE3RGJNd2JNWG1qM1NJdjZIc0FXRUpUMDR5SVJ4WENHRUVkdlpSRU03?=
 =?utf-8?B?UFB2WXdaZURzR3BKNm1ud1kvUlYxN1JtQlRBS0FoaStWaEIxYU9pd3JkeUlY?=
 =?utf-8?B?NEF5bkRNWGpGeXprNm9rRFdMY0JpU0VrZlMyb3N0cXZoa1BqYUhlSE1peVJZ?=
 =?utf-8?B?bTdma0lkekU5KytPU3Nuc2QyUXVObjRyRVhtK1JHN1RJS0VXYTBlU2lqYnJM?=
 =?utf-8?B?MzkydTNpV3Q2Y1ErT3k1RTdzWlVpRmZaUHIrUDlMMllNQ2p4dUgyTHR5S01r?=
 =?utf-8?B?aXZaWWtUTFUwWEUwVWhpV2NQdHR4RkVPV0dUOEk3Uzhrb2s1ZTJRWUNpRW9C?=
 =?utf-8?B?cFhDck4za29rOSt0KzhxM1BJRUJmZG9IK1hZVXY5ODdScjkyZ1VwZTQ0bmsz?=
 =?utf-8?B?Tng5UThYMnd1K1U0dXJsZVpuTmExRkQwSEhhRzY5RkZiNFRCTW1abzFWY3do?=
 =?utf-8?B?T2NYelh2NEhlN3NoRXVYTWVLazhLbHg5YkwrVUN5dWhmcWFYM2FBckdjZDd4?=
 =?utf-8?B?U1c4VFczVWFpdC9LNy9aSXhLckhmRjhWYmdtWTVncjQvMHMvckE2a1QxRkQv?=
 =?utf-8?B?MW42S3RXakM4OWx4TmR4TGFBaGZDekplQURxYjQ4a2g4bXY4ZHBPZzR0UjlW?=
 =?utf-8?B?aEU2ZkMzS1lMdEw3QlJsbWl3ZmY5Zm9OeDliOXdINVZqK0xkcXZaZ3FDMVRU?=
 =?utf-8?B?SlhlWXVCZklnOVhLalkwam5ienJwWDZJT0ZwanNBbkNFUk1rZE8wR0M5UWFk?=
 =?utf-8?B?VTBPZUJwY1RVS2QzUU5ZdU9DTWM3WDlFT3kwUVhLVzZsU0tBNWJ0cklpT09p?=
 =?utf-8?B?Q2JHbFdqbFR2WDVvUEMrWUVsVkhjL0dlVXJDNG00YWlNL1l2TVYzM2lWRm1v?=
 =?utf-8?B?dEZ6cnBNREExWlFwSUluZEExdlltMGNkNDJPSC9Qc2Jmc2Z5a2duRDFkSWwv?=
 =?utf-8?B?QlV1MUYyaDZqRk5rcmR4RTFxU3c2U3ZPRGxBYVIyUnFpTzNSNUJ5N1J4SEVT?=
 =?utf-8?B?VjlibnNEUXlTSjVBNEZ3SjFJZVhRWkNnZlZ2ZXkxRjVhYjZiQzh1Y1NqcTVN?=
 =?utf-8?B?bjB3eWtNUnN0Y3pweitjN3VMV092b2dpV2JwY1lzY2tVTlVTM3U2NUhjaWxX?=
 =?utf-8?B?OXl5MXVFbnVGZGprOTZpN1F3eHVTeUt5RDJGU0tNODRGanJOS01rVG1BTWFH?=
 =?utf-8?B?ckQrQm90RkdZZ3RLbG1HNHMyRHhCNjJQUTBvMzMwS2tocUJyLytoM3VUL3BH?=
 =?utf-8?B?ZmxJK2RRZG0xU3djWEdhbnRYTHJKRkozYmN3RnVpLzljMzdxNmlYOEFNbDJW?=
 =?utf-8?B?SUN2Q3g3RnI4cFJlVVpvcmYvajF4SlZvZXRDcHF0emNZTHFiVmp4RnBKWFdU?=
 =?utf-8?B?aEN5UnhrNGRXR3lLS2tvZHlMNWVVOUVtaERhVGRnUUVBTEpxZnpZd0pSZWFt?=
 =?utf-8?B?ajAyUnozVjd3PT0=?=
X-Microsoft-Antispam-Message-Info: 4J135ofh4pO5hKz4ePMME654Ha9/Dh2lmSPt1ReL9BelPPqJhCvLOMiZqp0IRLUt+3aq/u96xBJOL19qayRLpITvp7RBbodXlhcxCGFsXyswRStnKP19tSYvdVt9WgeO5o1Ut2+NLUcPG9AJpHMyrAYbNMc75O8O0WhHajYlBGEQTQ2bYMbmiOE309yQMMIf
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0320;6:+wtdPLgNN+SqK+0idLXgbaWHQparKI9TjuFizX5D9abSuTp7I+tYPz1Uw0OjvVWInIwEii7U2HsWiXMzESBPE5wpzan+5hbuocWFNTkYgTiW85Vrgd3jx/UaBYLxNudEllEDKHRovg3ueb87FQ4DUOOs0ZpAjWi4qG4n1AkY4NUpy0yIFCnZLs39uTroOE5HbUyZX7fFTZ4sWWqJf5kPjqF+zrcJz5hXXCvk2jsuvf5lOaFVhHyb29xSSx8DosC7c9lHhI+mRp566jMzvYq3ePEPMUuHG4QzpYA1BgrylH2oo8dpmgTJlJipomI25nKXMqLvvoA2oOe+a1LphiltOoVNelP4epVxM1P/+34BUZJxePaXky/98d18fqQJGGpntpc+QzX2N+xHmju2jvqQJ43uf8oMdaZCNv4jAbyT0XCp9GeiYs5ikQ9Ob3Om7+wF4Wpfv7i9jlh6AjDZU4MhEQ==;5:MyQop7PvUZoFOiiPCQyD4HLBtcT1gpV3P0AXwHxCjV60/J+LhVbgghEnVjUq4TBULFeP/uJEGV4eQorvqtVyAYc2AGZZ6Hxs/4lR2YtiklLzE9PG3X1bmm50Rw+TOaFUzfoL5Eu7hsr4JNeT8FxDIRbgHe3mL+JtkmWNQkovRgs=;24:HGOXM3mdEKSAP8m2f05e/en1WULNRySpt1pnDLWuabh3YavKWcFiLwTV0CUrvuu5SsT/vxVwWhlHuL9MO+zzctYR54+X+kq+4oDBHxDTjGQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0320;7:gc45Wpu0Cf0goFke1n8wqpwx8S3aK9xfR0v9D4uh8ANkfGywiEYB/WsC/klzB6wAvi5tURoculHjiOSzB+0Iu3fJiZ7WeuKe2I/Ji/L0lAcY6T5CcDmlLSDB4y5jaJeL//RVW9gLbz80+BS/emiV8/NMwgMxBH0X2vv9zk9q0sVGWLgoMRrU5AkzL3/oAX3ExlE31kA8HMBAGMQBiQXTnGeJi7SZLvDD3AHy+LbO/iOfi907fKnQoB4+0UdfcWgr;20:ySOyGwc+0TBsYxr+zIzOdKBtoYu7P5aHDIw/vwA15tLVA436qUbmxivNhVqxLZIBMoUynWNF05lX5sOlK1BJA40iTtwwLDncdnqlscni4HVQV+dJTrmXOF6eNU13OITTg8VA/v+HF8lGeKWE6ELdLStMV+vHqfD7EDO4D8+RU8ILZuOyq/eQADPao69Ewimr29uRrTgKg3zYvX/blp1ioazgafzBBDGPIH/WvmXdXH6Eudmg4ZsmKfWSjy65Vub1
X-MS-Office365-Filtering-Correlation-Id: b05bf68b-5ca4-4c82-25c4-08d5a9b195ab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 07:04:09.2181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05bf68b-5ca4-4c82-25c4-08d5a9b195ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0320
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598594949725044405?=
X-GMAIL-MSGID: =?utf-8?q?1598610165558767075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Tuesday 24 April 2018 11:35 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> 
> On Mon, Apr 23, 2018 at 9:02 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added dma configuration parameters in audio_substream_data
>> structure. Moved dma configuration parameters initialization
>> to dma hw params callback.
>> Removed separate byte count variables for playback and capture.
>> Added variables to store ACP register offsets in audio_substream_data
>> structure.
> 
> Thanks for splitting the patch, this is moving in the right direction, but
> still very difficult to review since it is mixing different changes
> together.
> Just try to make each patch a single logical cleanup.
> For example, perhaps create a set of patches that does:
>     (1) Variable renames (eg audio_config -> rtd) & white space cleanup
>     (2) Add dma configuration parameters to audio_substream_data structure
> and initialize them in hw_params.
>     (3) Remove separate byte count variables for playback and capture
>     (4) Update the PTE offsets
>     (5) Update the SRAM_BANKs
> 
> Note that (1) doesn't change functionality at all, (2) refactors but
> doesn't change behavior or logic, (3) simplifies behavior but doesn't
> change logic, and (4) & (5) build on the others but start making real
> logical changes.
> 
> -Dan

Hi Dan,

I will split the patch and re spin the patch set.

Thanks,
Vijendar
> 
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 241
> ++++++++++++++++++--------------------------
>>    sound/soc/amd/acp.h         |  35 +++++--
>>    2 files changed, 126 insertions(+), 150 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 5ffe2ef..4a4bbdf 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -317,54 +317,21 @@ static void acp_pte_config(void __iomem *acp_mmio,
> struct page *pg,
>>    }
> 
>>    static void config_acp_dma(void __iomem *acp_mmio,
>> -                          struct audio_substream_data *audio_config,
>> +                          struct audio_substream_data *rtd,
>>                              u32 asic_type)
>>    {
>> -       u32 pte_offset, sram_bank;
>> -       u16 ch1, ch2, destination, dma_dscr_idx;
>> -
>> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> -               sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -               destination = TO_ACP_I2S_1;
>> -
>> -       } else {
>> -               pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> -               switch (asic_type) {
>> -               case CHIP_STONEY:
>> -                       sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> -                       break;
>> -               default:
>> -                       sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
>> -               }
>> -               destination = FROM_ACP_I2S_1;
>> -       }
>> -
>> -       acp_pte_config(acp_mmio, audio_config->pg,
> audio_config->num_of_pages,
>> -                      pte_offset);
>> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
>> -
>> +       acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>> +                      rtd->pte_offset);
>>           /* Configure System memory <-> ACP SRAM DMA descriptors */
>> -       set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
>> -                                      audio_config->direction,
> pte_offset, ch1,
>> -                                      sram_bank, dma_dscr_idx,
> asic_type);
>> -
>> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
>> +       set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>> +                                      rtd->direction, rtd->pte_offset,
>> +                                      rtd->ch1, rtd->sram_bank,
>> +                                      rtd->dma_dscr_idx_1, asic_type);
>>           /* Configure ACP SRAM <-> I2S DMA descriptors */
>> -       set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
>> -                                      audio_config->direction, sram_bank,
>> -                                      destination, ch2, dma_dscr_idx,
>> -                                      asic_type);
>> +       set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
>> +                                      rtd->direction, rtd->sram_bank,
>> +                                      rtd->destination, rtd->ch2,
>> +                                      rtd->dma_dscr_idx_2, asic_type);
>>    }
> 
>>    /* Start a given DMA channel transfer */
>> @@ -700,7 +667,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
> 
>>    static int acp_dma_open(struct snd_pcm_substream *substream)
>>    {
>> -       u16 bank;
>>           int ret = 0;
>>           struct snd_pcm_runtime *runtime = substream->runtime;
>>           struct snd_soc_pcm_runtime *prtd = substream->private_data;
>> @@ -720,6 +686,7 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>>                   default:
>>                           runtime->hw = acp_pcm_hardware_playback;
>>                   }
>> +               adata->bytescount = 0;
>>           } else {
>>                   switch (intr_data->asic_type) {
>>                   case CHIP_STONEY:
>> @@ -728,6 +695,7 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>>                   default:
>>                           runtime->hw = acp_pcm_hardware_capture;
>>                   }
>> +               adata->bytescount = 0;
>>           }
> 
>>           ret = snd_pcm_hw_constraint_integer(runtime,
>> @@ -749,28 +717,6 @@ static int acp_dma_open(struct snd_pcm_substream
> *substream)
>>            */
>>           if (!intr_data->play_i2ssp_stream &&
> !intr_data->capture_i2ssp_stream)
>>                   acp_reg_write(1, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
>> -
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               intr_data->play_i2ssp_stream = substream;
>> -               /*
>> -                * For Stoney, Memory gating is disabled,i.e SRAM Banks
>> -                * won't be turned off. The default state for SRAM banks
> is ON.
>> -                * Setting SRAM bank state code skipped for STONEY
> platform.
>> -                */
>> -               if (intr_data->asic_type != CHIP_STONEY) {
>> -                       for (bank = 1; bank <= 4; bank++)
>> -
> acp_set_sram_bank_state(intr_data->acp_mmio,
>> -                                                       bank, true);
>> -               }
>> -       } else {
>> -               intr_data->capture_i2ssp_stream = substream;
>> -               if (intr_data->asic_type != CHIP_STONEY) {
>> -                       for (bank = 5; bank <= 8; bank++)
>> -
> acp_set_sram_bank_state(intr_data->acp_mmio,
>> -                                                       bank, true);
>> -               }
>> -       }
>> -
>>           return 0;
>>    }
> 
>> @@ -779,6 +725,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream
> *substream,
>>    {
>>           int status;
>>           uint64_t size;
>> +       u16 bank;
>>           u32 val = 0;
>>           struct page *pg;
>>           struct snd_pcm_runtime *runtime;
>> @@ -804,6 +751,60 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                   acp_reg_write(val, adata->acp_mmio,
>>                                 mmACP_I2S_16BIT_RESOLUTION_EN);
>>           }
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
>> +                       break;
>> +               default:
>> +                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +               }
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
>> +               rtd->destination = TO_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>> +               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> +               rtd->byte_cnt_high_reg_offset =
>> +               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>> +               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>> +               adata->play_i2ssp_stream = substream;
>> +               /*
>> +                * For Stoney, Memory gating is disabled,i.e SRAM Banks
>> +                * won't be turned off. The default state for SRAM banks
> is ON.
>> +                * Setting SRAM bank state code skipped for STONEY
> platform.
>> +                */
>> +               if (adata->asic_type != CHIP_STONEY) {
>> +                       for (bank = 1; bank <= 4; bank++)
>> +                               acp_set_sram_bank_state(adata->acp_mmio,
>> +                                                       bank, true);
>> +               }
>> +       } else {
>> +               rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
>> +                       break;
>> +               default:
>> +                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
>> +               }
>> +               rtd->destination = FROM_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>> +               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
>> +               rtd->byte_cnt_high_reg_offset =
>> +               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
>> +               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>> +               adata->capture_i2ssp_stream = substream;
>> +               if (adata->asic_type != CHIP_STONEY) {
>> +                       for (bank = 5; bank <= 8; bank++)
>> +                               acp_set_sram_bank_state(adata->acp_mmio,
>> +                                                       bank, true);
>> +               }
>> +       }
>> +
>>           size = params_buffer_bytes(params);
>>           status = snd_pcm_lib_malloc_pages(substream, size);
>>           if (status < 0)
>> @@ -837,26 +838,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream
> *substream)
>>           return snd_pcm_lib_free_pages(substream);
>>    }
> 
>> -static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
>> +static u64 acp_get_byte_count(struct audio_substream_data *rtd)
>>    {
>> -       union acp_dma_count playback_dma_count;
>> -       union acp_dma_count capture_dma_count;
>> -       u64 bytescount = 0;
>> +       union acp_dma_count byte_count;
> 
>> -       if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
>> -               playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
>> -               bytescount = playback_dma_count.bytescount;
>> -       } else {
>> -               capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
>> -               capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
>> -               bytescount = capture_dma_count.bytescount;
>> -       }
>> -       return bytescount;
>> +       byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
>> +
> rtd->byte_cnt_high_reg_offset);
>> +       byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
>> +
> rtd->byte_cnt_low_reg_offset);
>> +       return byte_count.bytescount;
>>    }
> 
>>    static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream
> *substream)
>> @@ -872,15 +862,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
> snd_pcm_substream *substream)
>>                   return -EINVAL;
> 
>>           buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>> -       bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
>> +       bytescount = acp_get_byte_count(rtd);
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
>>           pos = do_div(bytescount, buffersize);
>>           return bytes_to_frames(runtime, pos);
>>    }
>> @@ -898,21 +883,15 @@ static int acp_dma_prepare(struct snd_pcm_substream
> *substream)
> 
>>           if (!rtd)
>>                   return -EINVAL;
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> SYSRAM_TO_ACP_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH12,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_I2S_DMA_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH13,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       } else {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_SYSRAM_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH14,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> I2S_TO_ACP_DMA_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH15,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       }
>> +
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch1,
>> +                              rtd->dma_dscr_idx_1,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch2,
>> +                              rtd->dma_dscr_idx_2,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>>           return 0;
>>    }
> 
>> @@ -934,15 +913,13 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>           case SNDRV_PCM_TRIGGER_START:
>>           case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>           case SNDRV_PCM_TRIGGER_RESUME:
>> -               bytescount = acp_get_byte_count(rtd->acp_mmio,
>> -                                               substream->stream);
>> +               bytescount = acp_get_byte_count(rtd);
>> +               if (rtd->bytescount == 0)
>> +                       rtd->bytescount = bytescount;
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       if (rtd->i2ssp_renderbytescount == 0)
>> -                               rtd->i2ssp_renderbytescount = bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     SYSRAM_TO_ACP_CH_NUM, false);
>> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>>                           while (acp_reg_read(rtd->acp_mmio,
> mmACP_DMA_CH_STS) &
>> -
> BIT(SYSRAM_TO_ACP_CH_NUM)) {
>> +                               BIT(rtd->ch1)) {
>>                                   if (!loops--) {
>>                                           dev_err(component->dev,
>>                                                   "acp dma start
> timeout\n");
>> @@ -950,40 +927,21 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                                   }
>>                                   cpu_relax();
>>                           }
>> -
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     ACP_TO_I2S_DMA_CH_NUM, true);
>> -
>> -               } else {
>> -                       if (rtd->i2ssp_capturebytescount == 0)
>> -                               rtd->i2ssp_capturebytescount = bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     I2S_TO_ACP_DMA_CH_NUM, true);
>>                   }
>> +               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>>                   ret = 0;
>>                   break;
>>           case SNDRV_PCM_TRIGGER_STOP:
>>           case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>           case SNDRV_PCM_TRIGGER_SUSPEND:
>> -               /*
>> -                * Need to stop only circular DMA channels :
>> -                * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM.
> Non-circular
>> -                * channels will stopped automatically after its transfer
>> -                * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
>> -                */
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          SYSRAM_TO_ACP_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_I2S_DMA_CH_NUM);
>> -                       rtd->i2ssp_renderbytescount = 0;
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>> +                       ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>>                   } else {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          I2S_TO_ACP_DMA_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_SYSRAM_CH_NUM);
>> -                       rtd->i2ssp_capturebytescount = 0;
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>> +                       ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>>                   }
>> +               rtd->bytescount = 0;
>>                   break;
>>           default:
>>                   ret = -EINVAL;
>> @@ -1028,8 +986,6 @@ static int acp_dma_close(struct snd_pcm_substream
> *substream)
> 
> DRV_NAME);
>>           struct audio_drv_data *adata = dev_get_drvdata(component->dev);
> 
>> -       kfree(rtd);
>> -
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                   adata->play_i2ssp_stream = NULL;
>>                   /*
>> @@ -1059,6 +1015,7 @@ static int acp_dma_close(struct snd_pcm_substream
> *substream)
>>           if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
>>                   acp_reg_write(0, adata->acp_mmio,
> mmACP_EXTERNAL_INTR_ENB);
> 
>> +       kfree(rtd);
>>           return 0;
>>    }
> 
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 0e6089b..62695ed 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -10,17 +10,28 @@
>>    #define ACP_PLAYBACK_PTE_OFFSET                        10
>>    #define ACP_CAPTURE_PTE_OFFSET                 0
> 
>> +/* Playback and Capture Offset for Stoney */
>> +#define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
>> +#define ACP_ST_CAPTURE_PTE_OFFSET      0x00
>> +
>>    #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>>    #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4
> 
>>    #define ACP_PHYSICAL_BASE                      0x14000
> 
>> -/* Playback SRAM address (as a destination in dma descriptor) */
>> -#define ACP_SHARED_RAM_BANK_1_ADDRESS          0x4002000
>> -
>> -/* Capture SRAM address (as a source in dma descriptor) */
>> -#define ACP_SHARED_RAM_BANK_5_ADDRESS          0x400A000
>> -#define ACP_SHARED_RAM_BANK_3_ADDRESS          0x4006000
>> +/*
>> + * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
>> + * playback and SRAM Bank 2 for capture where as in case of BT I2S
>> + * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
>> + * be used for capture. Carrizo uses I2S SP controller instance. SRAM
> Banks
>> + * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be
> used
>> + * for capture scenario.
>> + */
>> +#define ACP_SRAM_BANK_1_ADDRESS                0x4002000
>> +#define ACP_SRAM_BANK_2_ADDRESS                0x4004000
>> +#define ACP_SRAM_BANK_3_ADDRESS                0x4006000
>> +#define ACP_SRAM_BANK_4_ADDRESS                0x4008000
>> +#define ACP_SRAM_BANK_5_ADDRESS                0x400A000
> 
>>    #define ACP_DMA_RESET_TIME                     10000
>>    #define ACP_CLOCK_EN_TIME_OUT_VALUE            0x000000FF
>> @@ -85,9 +96,17 @@ struct audio_substream_data {
>>           unsigned int order;
>>           u16 num_of_pages;
>>           u16 direction;
>> +       u16 ch1;
>> +       u16 ch2;
>> +       u16 destination;
>> +       u16 dma_dscr_idx_1;
>> +       u16 dma_dscr_idx_2;
>> +       u32 pte_offset;
>> +       u32 sram_bank;
>> +       u32 byte_cnt_high_reg_offset;
>> +       u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> -       u64 i2ssp_renderbytescount;
>> -       u64 i2ssp_capturebytescount;
>> +       u64 bytescount;
>>           void __iomem *acp_mmio;
>>    };
> 
>> --
>> 2.7.4
