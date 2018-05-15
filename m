Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeEOObV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:31:21 -0400
Received: from mx144.netapp.com ([216.240.21.25]:30103 "EHLO mx144.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeEOObS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:31:18 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="257439101"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>, Boaz Harrosh <boazh@netapp.com>
References: <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
 <20180515120355.GE31599@bombadil.infradead.org>
 <afe2c02f-3ecd-5f54-53ab-d45c11a5b4aa@netapp.com>
 <20180515135056.GG31599@bombadil.infradead.org>
 <da89bf77-fcb5-1c0c-f5ce-66e552d9a54d@netapp.com>
 <20180515141839.GI31599@bombadil.infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <c07e1d43-598e-ac20-316d-64f6b6a0a4c7@netapp.com>
Date: Tue, 15 May 2018 17:30:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515141839.GI31599@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::17) To CY4PR06MB3080.namprd06.prod.outlook.com
 (2603:10b6:910:58::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:CY4PR06MB3080;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;3:OjED+KtC8h+tA/49zaX80vvrKceXKUon6W9xjkURdEH6TXvcJLwjvkhHz0mrEtLSXpc7s4stto3b3XrNMGUbqEpVaCeojrVKKQc8QATQJwWa6DcjGzJobeaB/zFPCPpj+xaE1TcBkxfk48vfsNbY6Uy+DiFl6kC6rouhkLjp+92/JNjyS3x99mXe6VF5UdWOEmRMTYg48BVwhTOVJBSnfm9uRkA+UZKQSKl7aB84CATamE4Eyw9sqBPrUtfSNJ2p;25:24Si12vN1vb+uaMBAQWdN+/gPOZkxFmWDspyNvLQmS8rWsNJrvJwkp8kkJEEjznWecAw+2HaJqBRU/1z2FbizeOBRwXex7+DtWnpgteqojVRbr6Cr7J45NAg7OArUUZRWYJ6YZ+auVAfmhqO3zAz7adyqgcB6TI4bCWrySdcI72YFJ215uwe9d6Fr3MIqPJ1R8zui80eI6vQrIIjFpIV+AxkNVLjrkOjH4VFDTPORlQ7PI1AXV6MYe12K1ccmUpdEn92GDvpYtYvVgONQSCInc8/civVfccpTfriSfdCdB5uI2zxbFT8x0gYAwBaZvnQZSNRcj1WKtelhLkZjGb5AQ==;31:uaXUyaFKkQpZzYhKseVWSq0H/Sfv1qiPMnjoJIoPn4nI84Oh1hpGwnXhASoM7zq9Hn3UKn5OVo78goF5foAXbLx0/KHxYQj8mh3Sj6YegcJHAzbS1oyvNfTEb1ArH5JxPAiWcLS0Y3Qj5VICDhDFbKL4gHjE1+d0JkJxINq1QS8GEll7krvriYwjjOfNea2MrBCojVHG5p5oGtZtho/p2cjprkpjR16gDV99PZVXUNQ=
X-MS-TrafficTypeDiagnostic: CY4PR06MB3080:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;20:CzLsCrnmtEIrEEoqz7UUF91jYTW3DR4nJj4g1vw4r3LvDcEg5/gj0vIX9Iz4glaPU1uN0hRYGuYgYhrRORp44F2fixawZIwsHmhpwpUObeWi2kWe52zBCpKIwyZiCecGTnrElRoYq0U5SVYWcwpCr8RxlCEDTJ2QSyXeR/fg0g0AExhpyw9zR4SoYQcl3EE23XLDH6ODsvg5tQgTK/T1x4PflNlHYtTaBmaL47DrgELx8RYwkpuwA6Q5vc3AnMW8ATMfMX/0sbEgWzhddlUVLjt8ky6INQt2uJz/CpS8u46HmPhM7TcRBauFtjg5HnJzOYEKUFM/tpgWspmi8HRGOHSoM+3KDwWQl76ndUhv6xdFrNyT+yMvB69uE7X2DUs802tpVs8EUJIgq1FgTsRAomanIA3/X+GF98sznPOuH9r4CO35xj0+kr1gUwK/S5a5BzvzqES4VmIR9NlnekdXRtZN76Cp9/I5b/XHGmtGtDBTU2PfZM6EDRYBlKHWJhsn;4:W82Z+n8x0EbQUOS49EwSgKk3zLHDZvoK4qqIApgEPDLW2WdZFQ7zgxSWyCjYLv5zZ8rmQuTXBhAAzgdgnnyCEyhL1qIfcAyLc9MM1IZbI3tb5vnyWyssGudGvGNCijtai8FDL5YHXcU2i9CjiP66PAO3y8D9qCrm4o0176vsnrjCZZd1fIiomrG8RGraocB9bPQkEwr1G384XUZbARv4wI+kzIyBhcXtlgxC5DtGmlckjwUNeWM4OYA+GNQafr5udzto6xoFfI/WWFVRbdt67A==
X-Microsoft-Antispam-PRVS: <CY4PR06MB30801936635E197BDE80A7B5EE930@CY4PR06MB3080.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR06MB3080;BCL:0;PCL:0;RULEID:;SRVR:CY4PR06MB3080;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(199004)(189003)(52146003)(76176011)(52116002)(23676004)(2486003)(229853002)(77096007)(93886005)(16526019)(26005)(59450400001)(107886003)(68736007)(25786009)(6486002)(386003)(53546011)(8936002)(486006)(11346002)(956004)(2616005)(7736002)(36756003)(31696002)(305945005)(476003)(97736004)(5660300001)(446003)(31686004)(105586002)(7416002)(106356001)(8666007)(230700001)(65826007)(64126003)(58126008)(16576012)(316002)(110136005)(3846002)(6116002)(50466002)(6246003)(4326008)(53936002)(54906003)(6666003)(47776003)(81156014)(81166006)(72206003)(8676002)(65806001)(65956001)(478600001)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3080;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA2TUIzMDgwOzIzOnpQNWFCWWx2Kzh0T0VjY2FJVHovNmxXNkY4?=
 =?utf-8?B?Yy9oekVtaTZUb09zRi8rWWRVeWJ3S1FRZkkzTmZTd1BCeGpRTFVibjlkNGRU?=
 =?utf-8?B?NmhtaXpBY1g4SlhIa254eWhFV29NSEUydjRXUHJmNGpxUlovem9VbFp3QmE4?=
 =?utf-8?B?b1BqUkgyMHg1YnpMa3ZxWUJvc2ZwNHZBblpGajd0N0hzWk9UcE8zb3lIL2o0?=
 =?utf-8?B?aGZyY004c0JLdjZISm1WRmwwemRMODJxVVNteFdtYjN6elJXd09mcEVta0ta?=
 =?utf-8?B?UjB5Q3YvUHpZSGMycmhSN2N6K3ZhOGJENEd4RUlyKytFUWhhazFMS3gyaUNE?=
 =?utf-8?B?ZG0wNHhia0lLVmNqWWZtQld4OFlTeTU4WW5hQUZ4WC93LzlBQ29YY3lrT2tv?=
 =?utf-8?B?aElXNEowUnBMQ3lZQmlMQXBYYVAyMTZDcTZNWlVvT1dZa0FHM21qa3QvWGVn?=
 =?utf-8?B?SGlybXVrcDFsOFR6R2pEd01WVXVlWVlGYzdLNnY4dFhwbXJDdXN5SGU3aGE3?=
 =?utf-8?B?bGlWd3ZlR1ROTGNYaVZyQjlUbWplVWRwNFJBbFd0dFVSUURPZGk2R1pma3I5?=
 =?utf-8?B?TDZKMHZwaWY4RFpteGxpdGN5dDk5VWFnNWtsVFFjR2Fxa2w4K3d1L0xyNldv?=
 =?utf-8?B?SlRDNXpkeFdDWGx4OUVnOFpFOXY2MXF4TWllZXhLSTdBNExyT0Y3emJ6dHRB?=
 =?utf-8?B?MnBJYy9kcTZudVpYY0dGRmQ1N0paRnZXSkNjNytJVWxzVFhrc29QZVFwbm41?=
 =?utf-8?B?L09rUzlkWVJ0WDZXbXd0Rmw0N281ek41U1I0UjloalhkazMrdUY0RzlncGJv?=
 =?utf-8?B?Skd0cHFNWkh5bmtpWGdHakswMlZqam1DZ2hERW5xYTRnYm9LS2ZOK2tLS1BK?=
 =?utf-8?B?VU81SVBranU3cUNVV0Y3Sm53NkJqdy9VWkxUb3UzZ29RdU4wWDZLRFg2SnRX?=
 =?utf-8?B?YjVZVVZVTjRpWk9XZ3ZUa3ZjRi9GQlJ0d0Rkb3hBRUJTSk1RVFJyWWJRSlpO?=
 =?utf-8?B?UXdmRXhhVzdvVUhNaUpoaXUwWEVHTm9zU1p5bFNnN2hwNHJIVXVXbjZEQldm?=
 =?utf-8?B?YkNIby8yYUNoVnppckQ4M0wwV3kvSDVNcjVFbzBXU2x2aDRhU3QwMTh5TWxq?=
 =?utf-8?B?dFRIYVZuLzZQeG5UdHdzVlNNMytsUnA4c0dKVUU4c3NOSGFSSTU2aEJpRzIz?=
 =?utf-8?B?cWJ6aVNBdXVTMUN1MTdaRUVHOTZvZ0RYN0VMaWR6Rk1Fa0NQeWQ1MjUrbUdk?=
 =?utf-8?B?cFY1SmZ3RjNiZ095a3kxZjUyQzVxSXN0dFlVYWNVN2RjdnRVMDdpTktDMklV?=
 =?utf-8?B?bnlZY1V6SWlTTjhVSzhiRHl0RXg3VURDSktRWjd1YzFQOEp5eG1WZjdRYzJm?=
 =?utf-8?B?YWtsbXlhOUJMbFJuL3VtYWZ6Q0p0QTFLM1hBWWZXeEhzbUhMNmJENG1OQmtW?=
 =?utf-8?B?dTB0cTRQOVVzS1hDRmdyVnMxREs1OWU5VW1vR21DOTRhVDVHbThLaDB5dHo0?=
 =?utf-8?B?NkJVWmRSQTg2MUF5WTRoc0Rva3Y5VHlvWC90MldHamFJSnhCcW93OVlhNWFF?=
 =?utf-8?B?L3k0QWtnNzFuZnZRM0dIUUtlRjYzanZNNUdOa1hLUURHVlI3UmZ0U0U2T3hT?=
 =?utf-8?B?VVVpZkR5d2NINTg3cU9PREp0dldPMTVDUUdtQm90N3NzSXkyQ1VZSmVvMkNX?=
 =?utf-8?B?Y1NzUjRaZmorR2I4VHFVSEo1ZTNyc29HUXlnWjhkM1ZWRitVUUs5T1hoZXpU?=
 =?utf-8?B?L2xnOXNzWW40cE5CS2ZySDJaMStZcW5kWFVDbExHUFI4eVZONU9FaTNFUkFF?=
 =?utf-8?B?d1had2hVdFZSc2ZjY1BSUVhIbmYwa3BkS00wNlhzZGNiTGgzd3BHYS9pR3V0?=
 =?utf-8?B?TnRkR3FEeThPbXBYQlJPOXJLeVI3bFJkNGt5WXYrek5iVDVuQ1N4Sk1Va0cx?=
 =?utf-8?B?OVgvZXpSU1A0T1pQWm8wYVhzOS9xU3BQQyt0TURrZkdIQ1g5a2MyaTVSMHV5?=
 =?utf-8?B?MjJSdnlELzZBWHpwNkZVZ28rc1NTWC9PNFhWdnZRUk9wU2FWSy8vcWN6cGha?=
 =?utf-8?Q?IT9VY57O9WF45i6DV7Z+EGuuP?=
X-Microsoft-Antispam-Message-Info: EMtVMDAz78jzfsxZgT+EK44F6NlYm0vKp3MF+zqRSMA5Ifv6UeRYHgQofDhzO3vDk4mB/NBEfO/paDHhkVoVbjjddm2zxc7Fn7dDQIlMDnQQJ4DFSNrApJF6ZBaovK4F9wB0No7duTikhLeuzspZ6HzmYyWXnTjsY+bQqCswymelHWAIvbXDaSTu2J/XHzUs
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;6:prENiA65rOYFHAkRgc1+dynpDdAMvpQ0WVSuQXErZkzsSVQP/MYsrvgyBxCXUcBKIFLzQlUrZ3nbmvZhRAMtj2CktXBQetLdWiVv51cKPWy1coOHEymhJZ5cPYwZbemSlnhNioZJW6Vi6Y/i/bywu0YQD+w6CrRMCu3lGyEPLjocwJrFNqkLVT+74/ejnWiAAIdOE/RZ7o+OioUKrIwoQoMsektN1ZA52ssi6EIldcewvqyCNDqAQOjMRqk/zRXQ3EgzB0TrItvIiIDE94Ldsm2G7vf98EVU7CgQ3IJJvbPFx5rq/OIn4VaaNyU9ZWydgtZTPkrHVsoMeP4GyrVDtpOKLSCxJZlpNKMonsujDYt4ELfvUxf7U4ocPit38FAAcEuzTsbJyZi6wMjrYK0swGmjw+saF0E8oayGMPNFMltwdb7WDujhVhl/pZ231OI1wrgdROv6K74NVwhxEAdUcQ==;5:qnDFAfImuDX1WrbeNrPv06d84Pyv1FIT3Mr5VuSWORuglzmF2IJd2kmI0uoB2GvwM7MLa/hXJ/Ec4Foiis5QNgozfRpsM+vn9SXsr9FdE9QFA11Q+4cHWjbQQg0k9/yZZ0u6V7L5qt3RDwlZLVw/SiEJuFT+XgAHPHht+Ua1znI=;24:45oTnaFHmt27COmrKtYAg5WF3TNyI4Kr+9Dl3S9ehJQogtWQi44bGmyE49ZQpq2JUpB+eauBdhXJFNS/QTEjOxPWNAI8n2FkinDjhIdEMNA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;7:chD79eYylxW1/ErxlgRKJo3xOo70J0tON8nmGjhekAuIfoqTGXf4VFjmv20Hg9sTuFVYZEyBSJ6qgmeDVWqL8UCGDfLF58qM79oBYiQeaAdRX4V9s3v3owT9aehdbfNkqIWGD4I+sSNHEVvb9D0rBWNJVqh7C2ubu7vmSMTf6RnIZu3bS9WY/fg/4pFVCDdtMgqnZi7hGix3fjfQaxGS2ZfDEyQkl7t+MFe+MDA1q/bnYGkfi9Go6OVjtH80FZcP
X-MS-Office365-Filtering-Correlation-Id: 2dffd3ef-fa85-4888-56e7-08d5ba70834a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:31:10.0677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dffd3ef-fa85-4888-56e7-08d5ba70834a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3080
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 17:18, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 05:10:57PM +0300, Boaz Harrosh wrote:
>> I'm not a lawyer either but I think I'm doing OK. Because I am doing exactly
>> like FUSE is doing. Only some 15 years later, with modern CPUs in mind. I do not
>> think I am doing anything new here, am I?
> 
> You should talk to a lawyer.  I'm not giving you legal advice.
> I'm telling you that I think what you're doing is unethical.
> .
> 

Not more unethical than what is already there. And I do not see how
this is unethical at all? I trust your opinion and would really want
to understand.

For example your not-in-c zero-copy Server. How is it unethical?
I have the same problem actually some important parts are not in C.

How is it unethical to want to make this run fast?

Thanks
Boaz
